# Rails App Structure Standard

## Introduction
  Given the many different styles and ways to code in Rails, we’ve decided to set a standard to guide coders into what we feel is the cleanest, most satisfactory method we’ve found so far. Feel free to debate over the points stated, as the number one idea behind good engineering in general is to be continuously adapting and improving.

## App Structure
  As you may have noticed when you look into your Rails project, there is a dizzying variety of directories. Thankfully, Rails has an [explanation](http://guides.rubyonrails.org/getting_started.html#creating-the-blog-application) for these, so these can be used as a good guideline.

  However, when you begin coding, you might find yourself wondering where to stick a certain class in. If it’s a class that only performs requests to a third-party server, where would that go? What about a class that performs tough business logic calculations?

## Directories
  We have a few extra directories defined in our standard to fill in most of these gaps.

### Lib
  First off is `lib/`. This is actually one of the default directory in a Rails app, but we wanted to clear up a bit of confusion that surrounds it. The problem is that the definition Rails gives for it is super ambiguous. “Extended modules for your application.” That sounds like it could be anything!

  So we decided to take it very literally. We use the `lib` directory to extend any base Ruby or Rails/ActiveSupport modules for use in our application. Nothing else, nothing more. Most of the time, you won’t be needing this directory too much.

  We HAVE had problems with loading `lib` at times, so if it happens to be a problem to you in production, go ahead and move `lib` to `app/lib`, and it’ll work just fine.

### Services
  `app/services` is up next. “Service” is another name for a class that isn’t too specific. Different people call different stuff services. Therefore, we have to be very concise and clear when explaining these.

  Services are just classes that you use to communicate with external APIs, be it a third-party API, another server in your service-oriented architecture, or an IOT device. They handle requests, and any possible errors that come up while performing them.

### Poros
  Now goes `app/poros`. “A poro? What’s that?” is what you’re thinking, perhaps. No, it’s not one of [these](http://vignette1.wikia.nocookie.net/leagueoflegends/images/6/66/Fat_Poro_Icon.png/revision/latest?cb=20150215130030)! A PORO stands for Plain Old Ruby Object.

  So… Just any Ruby class? Sounds more ambiguous than any of those before, right? The thing is, poros should contain classes that contain granular business logic, or some sort of process that serves an ultimate purpose in the business cycle. Sound confusing? Basically, it should be a class that contains a small independent piece of the logic behind your application. It receives one input on creation and does not need to fetch stuff, it just performs whatever it needs to. This could mean a parser, a calculator of some sort, a lot of things really.

  To keep `app/poros` from becoming just a garbage dump for classes you aren’t sure where to place, be sure to create as many subdirectories as you see fit to keep things organized. For example, if you have many parsers you feel you can group together, you can put them all into `app/poros/parsers`.

  If you find you usually have the same kind of poros throughout more than one app, you can move them out of the poros directory and into their own directory. Continuing our previous example, if all your apps have many parsers, instead of having a `app/poros/parsers` directory in each one, you can place them in `app/parsers`.

### Interactors
  Last but not least are interactors! Interactors are where the big bulk of business logic goes. As the name implies, they are the classes where various poros and models work together to achieve a certain use case or business process. They can even use other interactors!
  It is very important to notice that interactors should not, however, be huge classes. They are mostly just calls to other objects and the small logic between them.

  You can read a bit more on interactors [here](https://mkdev.me/en/posts/a-couple-of-words-about-interactors-in-rails).

## But what about models and controllers?

  Frankly, we believe that controllers and models should remain relatively slim.

  Controllers should only contain rendering logic and a call to a corresponding poro or interactor.

  Models can be controversial, and some people are fond of fat business-logic-containing models. We opt for slim models: we don’t believe they should be stripped of all behaviour, but definitely shouldn’t house most of the business code.

  Code that is simple and self-contained can go into a model, such a self-generating unique code on creation. Code that interacts with other objects (be it models, poros or anything else) is a big no-no.

  Keep in mind that view or presentation logic should not be in the model either! (It can go into a decorator poro!)

  Also, we are not big fans of `before_*` and `after_*` callbacks in a model since they can be tough to debug and aren’t super visible. The actual callbacks should be done in the poros or interactors where it is required. That way the code is easy to follow, without any surprises from an invisible callback!
