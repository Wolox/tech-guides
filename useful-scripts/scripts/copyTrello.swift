import Foundation
import Alamofire

extension String {

    func getReferencedURL() -> String {
        do {
            let URLRegex = "^((http[s]?|ftp):\\/)?\\/?([^:\\/\\s]+)((\\/\\w+)*\\/)([\\w\\-\\.]+[^#?\\s]+)(.*)?(#[\\w\\-]+)?$"
            let regex = try NSRegularExpression(pattern: URLRegex)
            let nsString = self as NSString
            let result = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return nsString.substring(with: result[0].range)
        } catch {
            print("👮  Invalid regex.")
            exit(1)
        }
    }

}

struct Card: Decodable {

    let id: String
    let idChecklists: [String]
    let name: String
    let desc: String
    let url: String

}

struct Board: Decodable {
    let id: String
    let name: String
    let url: String
    let idOrganization: String
}

struct Checklist: Decodable {
    let id: String
    let idBoard: String
    let idCard: String
    let name: String
    let checkItems: [ChecklistItem]

    struct ChecklistItem: Decodable {
        let id: String
        let name: String
    }
}

final class TrelloRepository {

    private static let TimeOutInterval: Double = 10

    private static let APIBasePath = "https://api.trello.com/1"
    private static let BoardsPath = "/boards"
    private static let CardsPath = "/cards"
    private static let ChecklistsPath = "/checklists"
    private static let ChecklistItemPath = "/checkItem"

    private let _APIKey: String
    private let _token: String
    private let _decoder = JSONDecoder()

    init(APIKey: String, token: String) {
        _APIKey = APIKey
        _token = token
    }

    func fetchCards(from idBoard: String) throws -> [Card] {
        let url = TrelloRepository.APIBasePath + TrelloRepository.BoardsPath + "/" + idBoard + TrelloRepository.CardsPath
        let parameters: Parameters = ["key": _APIKey, "token": _token]
        let json = makeSynchronousRequest(url: url, method: .get, parameters: parameters)
        return try parse(maybeJSON: json, to: [Card].self)
    }

    func fetchBoard(from idBoard: String) throws -> Board {
        let url = TrelloRepository.APIBasePath + TrelloRepository.BoardsPath + "/" + idBoard
        let parameters: Parameters = ["key": _APIKey, "token": _token]
        let json = makeSynchronousRequest(url: url, method: .get, parameters: parameters)
        return try parse(maybeJSON: json, to: Board.self)
    }

    func copyBoard(_ board: Board,
                   keepFromSource: String = "cards",
                   permissionLevel: String = "org",
                   with newBoardName: String) throws -> Board {
        let url = TrelloRepository.APIBasePath + TrelloRepository.BoardsPath
        let parameters: Parameters = ["key": _APIKey,
                                      "token": _token,
                                      "name": newBoardName,
                                      "idBoardSource": board.id,
                                      "idOrganization": board.idOrganization,
                                      "prefs_permissionLevel": permissionLevel,
                                      "keepFromSource": keepFromSource]
        let json = makeSynchronousRequest(url: url, method: .post, parameters: parameters)
        return try parse(maybeJSON: json, to: Board.self)
    }

    func fetchChecklist(with idChecklist: String) throws -> Checklist {
        let url = TrelloRepository.APIBasePath + TrelloRepository.ChecklistsPath + "/" + idChecklist
        let parameters: Parameters = ["key": _APIKey, "token": _token]
        let json = makeSynchronousRequest(url: url, method: .get, parameters: parameters)
        return try parse(maybeJSON: json, to: Checklist.self)
    }

    func updateChecklistItem(from idCard: String, where idChecklistItem: String, with newItemDescription: String) {
        let url = TrelloRepository.APIBasePath + TrelloRepository.CardsPath + "/" + idCard + TrelloRepository.ChecklistItemPath + "/" + idChecklistItem
        let parameters: Parameters = ["key": _APIKey,
                                      "token": _token,
                                      "name": newItemDescription]
        _ = makeSynchronousRequest(url: url, method: .put, parameters: parameters)
        return
    }

    private func parse<T>(maybeJSON: Data?, to object: T.Type) throws -> T where T: Decodable {
        guard let json = maybeJSON else {
            print("👮  \(object) fetching failed.")
            exit(1)
        }
        do {
            let objectFromJSON = try _decoder.decode(T.self, from: json)
            return objectFromJSON
        } catch {
            print("👮  Invalid \(object) JSON.")
            exit(1)
        }
    }

    private func makeSynchronousRequest(url: URLConvertible,
                                        method: HTTPMethod,
                                        parameters: Parameters) -> Data? {
        var output: Data?

        let headers: HTTPHeaders = ["Accept": "application/json"]

        let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers)
        request.validate(contentType: ["application/json"]).responseJSON { response in
            output = response.data
        }

        let task = request.task
        let timeout = Date(timeIntervalSinceNow: request.request?.timeoutInterval ?? TrelloRepository.TimeOutInterval)
        while task!.state == .running && !RunLoop.current.run(mode: .defaultRunLoopMode, before: timeout) { }

        return output
    }
}

// MARK: - SCRIPT

// TODO: Ask via readLine() when it works. See https://github.com/JohnSundell/Marathon/issues/112
let arguments = CommandLine.arguments

guard arguments.count > 3 else {
    print("👮  Expected 4 arguments: APIKey, token, board ID and new board name.")
    exit(1)
}

let APIKey = arguments[1]
let token = arguments[2]
let idBoard = arguments[3]
let nameBoard = arguments[4]

guard APIKey.count == 32 else {
    print("👮  \(APIKey) is an invalid API Key.")
    exit(1)
}

guard token.count == 64 else {
    print("👮  \(token) is an invalid token.")
    exit(1)
}

guard idBoard.count > 0 else {
    print("👮  Board ID cannot be left blank.")
    exit(1)
}

guard nameBoard.count > 0 else {
    // TODO: also pass regex to verify format.
    print("👮  New board name cannot be left blank.")
    exit(1)
}

let repository = TrelloRepository(APIKey: APIKey, token: token)

let baseBoard = try repository.fetchBoard(from: idBoard)

// TODO: Ask user to keep going with the parameters entered when readLine() works.

let newBoard = try repository.copyBoard(baseBoard, with: nameBoard)
let baseBoardCards = try repository.fetchCards(from: baseBoard.id)
let newBoardCards = try repository.fetchCards(from: newBoard.id)

var cardDictionary = Dictionary<String,String>()
for i in 0 ... baseBoardCards.count - 1 {
    cardDictionary[baseBoardCards[i].url] = newBoardCards[i].url
}

for card in newBoardCards {
    if card.idChecklists.count != 0 {
        for idChecklist in card.idChecklists {
            let checklist = try repository.fetchChecklist(with: idChecklist)
            for i in 0 ... checklist.checkItems.count - 1 {
                let newCardText = checklist.checkItems[i].name
                let idItem = checklist.checkItems[i].id
                let baseBoardURL = newCardText.getReferencedURL()
                let newBoardURL = cardDictionary[baseBoardURL]
                let newItemDescription = newCardText.replacingOccurrences(of: baseBoardURL, with: newBoardURL!)
                repository.updateChecklistItem(from: checklist.idCard, where: idItem, with: newItemDescription)
            }
        }
    }
}

print("✅  Successfully created Trello board with name \"\(nameBoard)\". Find it at \(newBoard.url)")
exit(0)
