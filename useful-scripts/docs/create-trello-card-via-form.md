### Script to create a Trello card from a google form

#### Create Google Form

1. Go to Drive
2. Click on New
3. Select Form
4. Create the form as needed.

#### Create the script to create Trello card from each form response
5. Go to responses Srpreadsheets.
6. Go to tools -> script editor
7. Create the following function:

function onFormSubmit(e) {
  try{
    var email = "xxxxx@boards.trello.com"; //check the email according the Trello board

    //value 0 is response timestamp
    var response-first-field = e.values[1];
    var response-n-field = e.value[n];

    var subject = "Trello card title" + response-first-field;
    var body = "Trello card description : \n" + response-n-field;

    MailApp.sendEmail(email, subject, body);
  }catch(e){
    Logger.log(e.toString());
  }
}

Here are the instructions to get the email to create cards in a specific Trello board and the formatting tips
http://help.trello.com/article/809-creating-cards-by-email

#### Set the trigger for the script
8. Go to Edit -> Current project's triggers
9. Set the following fields:

Run: the function

Events: From spreadsheet
		on form submit
