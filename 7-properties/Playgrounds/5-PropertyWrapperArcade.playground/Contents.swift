/*
  ___                       _         __      __
 | _ \_ _ ___ _ __  ___ _ _| |_ _  _  \ \    / / _ __ _ _ __ _ __  ___ _ _
 |  _/ '_/ _ \ '_ \/ -_) '_|  _| || |  \ \/\/ / '_/ _` | '_ \ '_ \/ -_) '_|
 |_| |_| \___/ .__/\___|_|  \__|\_, |   \_/\_/|_| \__,_| .__/ .__/\___|_|
             |_|                |__/                   |_|  |_|
                           _                  _
                          /_\  _ _ __ __ _ __| |___
                         / _ \| '_/ _/ _` / _` / -_)
                        /_/ \_\_| \__\__,_\__,_\___|

 */

import Foundation

/*
🕹 Wrapping all the things.

    If we find ourselves doing many of the same things to many our properies, and @propertyWrapper can be handy for encapsulating the functionality into one construct.

    For example remember our Post trimmer from a previous example? If we wanted to repeat the funcionanlity for more properties, and not have to repeat the property observer didSet functionality, we could wrap it in a @propertyWrapper, and use it in our Post.

 */

struct OldPost {
    var title: String {
        didSet {
            self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var body: String {
        didSet {
            self.body = body.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}


@propertyWrapper
struct Trimmed {
    private(set) var value: String = ""

    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}

struct Post {
    @Trimmed var title: String
    @Trimmed var body: String
}

var post = Post(title: "  Swift Property Wrappers  ", body: "…")
post.title // "Swift Property Wrappers" (no leading or trailing spaces!)

post.title = "      @propertyWrapper     "
post.title // "@propertyWrapper" (still no leading or trailing spaces!)

/*
 Discussion:

 By marking each String property in the Post structure below with the @Trimmed annotation, any string value assigned to title or body — whether during initialization or via property access afterward — automatically has its leading or trailing whitespace removed.

 That is a subtle but important distinction between property observers and wrappers. Wrappers apply the processing during initialization, while didSet property observers don't. So if you want consistent processing, go with the wrapper.
 */


// https://nshipster.com/propertywrapper/
