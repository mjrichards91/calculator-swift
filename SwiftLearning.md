# Swift Learning

## Constant

```swift
let maximumNumberOfLoginAttempts = 10 
```

Helpful to let the reader & Swift know this value is never going to change. This holds true for arrays and dictionaries as well. This makes the actual code perform more efficiently.

Constants are also often defined in structs to be grouped together and types them:

```swift
private struct Ratios {
    static let skullRadiusToEyeOffset: CGFloat = 3
    static let skullRadiusToEyeRadius: CGFloat = 10
    static let skullRadiusToMouthWidth: CGFloat = 1
    static let skullRadiusToMouthHeight: CGFloat = 3
    static let skullRadiusToMouthOffset: CGFloat = 3
}
```

## Variable

```swift
var currentLoginAttempt = 0
var welcomeMessage: String
```

The type can be inferred with an initial value and the type is not necessary.

### Multiple variable declarations: 

```swift
var x = 0.0, y = 0.0, z = 0.0
var red, green, blue: Double
```

## Strings

### Interpolation:

```swift
var friendlyWelcome = "Hello!"
print("The current value of friendlyWelcome is \(friendlyWelcome)”)
```

### “ToString”

```swift
String(somevar)
```

## Methods

```swift
func drawHorizontalLine(from startX: Double, to endX: Double, using color: UIColor) {
}
```

`from`: is the name of the EXTERNAL parameter (used by the callers)  
`startX`: is the name of the INTERNAL parameter (used internally to the func)

```swift
func returnSomething() -> String {
}
```

returns a string value

```swift
func doSomething(_ someValue: String) -> String {
}
```

`_` is the external parameter, this removes the requirement for named parameters. Used most often as the first argument - NEVER for subsequent ones.

Methods can be nested (i.e scoped to another):

```swift
func doSomething() {
    func scopedMethod() {
    }
}
```

## Logging:

Homework: https://stackoverflow.com/questions/25951195/swift-print-vs-println-vs-nslog

## Optionals

Has 2 values: set and not set. A set optional has an associated value “on the side”. `String?` means an associated string value (that is optional) that could be set or not set.

An `!` unwraps the associated value. If there is not associated value, then the app will crash and burn.

Optionals do not have to unwrapped to set.

### Implicitly unwrapped optional:

```swift
@IBOutlet weak var display: UILabel!
```

Declarations with a `!` automagically unwraps the optional value as the `?` does not. Throws an exception if the value happened to be nil.

An optional is just an `enum`:

```swift
enum Optional<T> {
    case none
    case some(T)
}
```

Defaulting:

```swift
// If s is nil, will set to the empty string, otherwise s
display.text = s ?? " "
```

Optionals can be "chained":

```swift
var display : UILabel?

if let x = display?.text?.hasValue { ... } // x is an Int as "if let" unwraps it

let x = display?.text?.hasValue { ... } // x is an Int? as it was never officially "unwrapped"
```

## UI

`UILabel?` or `UILabel!` is optional so that iOS has time to connect the UI to the property

## Conventions

Clarity over brevity!

Semicolons are NOT required but are if multiple statements are on a single line:

```swift
let cat = “cat"; print(cat)
```

## Properties

All properties must be initialized unless they are optionals. Behind the scenes, optionals are set to `nil`.l

### Computed properties:

```swift
 var displayValue: Double {
    get {
        return Double(display.text!)!
    }
    set {
        display.text = String(newValue)
    }
}
```

### Read-only properties

```swift
var result: Double {
    get {
        
    }
}
```

### Property Observers

Can observe changes to any property via `willSet` and `didSet`.

```swift
var someProperty: Int = 42 {
    willSet { newValue }
    didSet { oldValue }
}
```

### Lazy Properties

Does not get initialized until accessed. Useful for expensive operations that are used to set the property.

```swift
// Set and initialize lazily
lazy var brain = CalculatorBrain()

// Set and initialize lazily via a closure
lazy var someProperty: Type = {
    return someValue;
}()

// Set and initialize lazily via a method
lazy var myProperty = self.initializeMyProperty()
```

### private

```swift
private var accumulator: Double
```

## MVC

### Model

* What your app is
* UI independent parts
* Only is accessed by the view controller
* Notifies controller of its changes

### Controller

* How to display what your app is
* Accesses the models and decides how it should be sent/transformed to the view (outlet)

### View

* What the controller uses to display itself
* Does not access models
* Sends action and delegate information to the view controller
* Does not own the data is displays - asks for its data from a data source on the controller
* Does the communication between multiple MVCs

## struct

* Do not have inheritance like classes do
* Are passed by copying (rather than by reference)
* Initializes all properties by default. Do not need to set initial values for properties.

```swift
 mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
```

funcs must be mutating to allow changing a value in a struct since they are passed by copy.

```swift
private struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
        return function(firstOperand, secondOperand)
    }
}
```

* The 2 properties are constants (via `let`) as when a new `PendingBinaryOperation` is created, it will be initialized with values that do not ever change.
* Also, the `perform` function is not mutating since it does not ever change a property value, but rather returns a new one.

## Dictionary

```swift
private var operations: Dictionary<String, Double> = [
        "π" : Double.pi,
        "e" : M_E
]
```

Accessing a dictionary value `operations[symbol]` returns an optional as it may not exist.

## enum

```swift
struct CalculatorBrain {

    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double),
        case binaryOperation((Double, Double) -> Double),
    }
}
```

* Can define an enum class within another class/struct
* Enums can also have an associated value.
    * The `constant` enum has an associated Double value can can be assigned like `Operation.constant(Double.pi)`
    * The `urnaryOperation` enum has an associated function that takes a double and returns a double like `Operation.unaryOperation(sqrt)`.
    * The `binaryOperation` enum has an associated function that takes TWO doubles and then returns a double

## Playground

Playground is a "fiddle" in Xcode that is used to evaluate code separate of a project. This is helpful to try out code without impacting your project.

## Closures

```swift
Operation.binaryOperation({ $0 * $1 }),
```

Defines a closure to use for the `binaryOperation((Double, Double) -> Double)` signature. Swift can infer the parameter and return types so they do not need to be defined. Swift also indexes its parameters using `$` notation with numbers representing the parameter order.

## Tuples

```swift
// The bad way, but valid
let x: (String, Int, Double) = ("hello", 5, 0.85)
let (word, number, value) = x
print(word)
print(number)
print(value)
```

OR

```swift
// Use named parameters (strongly preferred)
let x: (w: String, i: Int, v: Double) = ("hello", 5, 0.85)
print(x.w)
print(x.i)
print(x.v)
```

Can be used as a return value from a function:

```swift
func getSize() -> (weight: Double, height: Double) { return (250, 80) }
```

## Range

Represents 2 endpoints like a selection of text or portion of an array.

```swift
let array = ["a", "b", "c", "d"]

let a = array[2...3] // contains ["c", "d"]
let b = array[2..<3] // contains ["c"]
```

Out of bounds exceptions will occur with Ranges.

CountableRange (i.e. can be iterated over):

```swift
// Range can be iterated over. This works with the above array example too
for i in 0..<20 {
}
```

```swift
// Range can also be iterated over by using the increment
for i in stride(from: 0.5, through: 15.25, by: 0.3) {
}
```

## final

Can mark a function or entire class to prevent it from being overridden.

## Array

```swift
var a = Array<String>()

var a = [String]() // preferred way

let animals = ["Giraffe", "Cow"] // inferred as a [String]
animals.append("Dog") // will not compile as let makes it immutable
```

Array closures (i.e. lambdas):

```swift
let bigNumbers = [2,47,118,5,9].filter({ $0 > 20 }) // bigNumbers = [47, 118]

let stringified: [String] = [1,2,3].map { String($0) } // Can omit parenthesis if closure is trailing (last argument)

let sum = [1,2,3].reduce(0, +) // + is just a function in Swift
```

## Dictionary

```swift
var pac12teamRankings = Dictionary<String,Int>()

var pac12teamRankings = [String:Int]() // preferred way

var pac12teamRankings = ["Standford":1, "USC":11]
let ranking = pac12teamRankings["Ohio State"] // ranking is an Int? (nil)
pac12teamRankings["Cal"] = 12
```

Dictionaries are enumerated via a tuple:

```swift
for (key, value) in pac12teamRankings {
    print("Team \(key) is ranked number \(value)")
}
```

## String

Accessing specific characters in a string (the horrible way):

```swift
let s: String = "hello"

let firstIndex : String.Index = s.startIndex
let firstChar: Character = s[firstIndex] // "h"

let secondIndex: String.Index = s.index(after: firstIndex)
let secondChar: Character = s[secondIndex] // "e"

let fifthChar: Character = s[s.index(firstIndex, offsetBy: 4)] // "o"

let substring = s[firstIndex...secondIndex] // "he"
```

String contains a property `characters` that can be iterated and accessed by index:

```swift
for c: Character in s.characters { } // iterates over each character

let count = s.characters.count

let firstSpace: String.Index = s.characters.index(of: " ") // returns index of the first space
```

Strings follow the same mutable/immutable rules as other types do.

Many, many other helper functions exist for a String in the documentation. Stop writing a bunch of code and check if there is a helper function!

## NSObject

Base class for all Objective-C classes and is required by some advanced features of Swift.

## NSNumber

Generic number-holding class. Preferred to use Swifts specific number classes (Int, Double, etc.)

## Date

Handles all date, calendar, formatting, etc. functionality.

## Data

A value type that represents bits. Used to save/restore/transmit raw data.

## Initialization

* `init` is required for members that do not use default values, Optionals, closures, or lazy initialization.
* `init()` is given "fo free" for all base classes unless a custom init is provided.
* Allowed to set `let` values (similar to C# `readonly` initialization)
* What is required?
    * All properties must have values and must be set before the superclass's is called
    * Superclass's init must be called before a value is assigned to any inherited property
    * All inits must be called before accessing any members
* inits can be inherited
* inits can be required (all subclasses must implement it)
* `init?` is marked as failable and returns an Optional

## Any & AnyObject

Used mostly for backwards compatibility with Obj-C since Swift is strongly typed. Represents anything (duh).

```swift
func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

Can be seen with an array of different object types but this goes against all that Swift believes in.

To cast an Any as a specific type:

```swift
let unknown: Any = ...

if let foo = unknown as? MyType { ... }
```

## UserDefaults

Lightweight "database" of values to persist between launchings of the app.

```swift
let defaults = UserDefaults.standard

defaults.set(3.1415, forKey: "pi")
let pi = defaults.double(forKey: "pi")
```

Saving is done automagically, but can be forced via:

```swift
defaults.synchronize()

if !defaults.synchronize() { } // failed to synchronize
```

## Assertions

Assertions can be used as a debugging aid and do not execute in published apps.

```swift
assert(() -> Bool, "message")
```

## Views

Manually add/remove views:

```swift
func addSubview(_ view: UIView)
func removeFromSuperview()
```

Generally initializers should be avoided, but are more common to have in UIViews. If you need an initializer, implement them both:

```swift
init(frame: CGRect) // init if view is created in code
init(coder: NSCoder) // init if view is created in a storyboard
```

Views are coded into XML.

`awakeFromNib()` is immediately called after initialization is complete.

`CGFloat` is used to represent coordinates within a UIView. This should always be used over Double or Float.

`CGPoint` represents x, y coordinates.

`CGSize` represents a width and a height.

`CGRect` is a struct with a CGPoint and CGSize. Many helper methods to aid in fine-tuning a view.

The origin (0,0) of the coordinate system is in the upper left corner.

Units are points, not pixels. Devices have many pixels per point. To get the number of pixels per point on the device (could be 1, 2, or 3 currently):

```swift
var contentScaleFactor: CGFloat
```

```swift
var bounds: CGRect // Bounds represents the size in which is available to draw.
```

Never use these to draw, but rather to position:

```swift
var center: CGPoint // Center of a UI view within its superview
var frame: CGRect // Rect of a UIView within its superview
```

Creating a view via code:

```swift
let newView = UIView(frame: myViewFrame)
let newView = UIView() // frame will be CGRect.zero
```

To draw, override its `draw` method:

```swift
override func draw(_ rect: CGRect) // rect is purely an optimization as the bounds is what describes the entire drawing area
```

NEVER call the draw the method as it will be called by the system. To request a redraw to happen at the appropriate time:

```swift
setNeedsDisplay()
setNeedsDisplay(_ rect: CGRect) // only a specific area to be redrawn
```

Add `@IBInspectable` to let a custom view's property be editable from a storyboard.

### Core Graphics Concepts

1. A context is needed to draw into. Can be retrieved by calling `UIGraphicsGetCurrentContext()`.
1. Create paths out of lines, arcs, etc.
1. Set attributes like colors, fonts textures, etc
1. Stroke or fill the paths

To define a path:

```swift
let path = UIBezierPath()
path.move(to: CGPoint(80, 50))
path.addLine(to: CGPoint(140, 150))
path.addLine(to: CGPoint(10, 150))
path.close() // if you want
```

To fill and stroke it:

```swift
UIColor.green.setFill() // defines green as the current fill color
UIColor.red.setStroke() // defines red as the current stroke color
path.lineWidth = 3.0
path.fill() // fills with green
path.stroke() // strokes with red
```

To add clipping `addClip()` and many many other helpful methods available for a UIBezierPath.

Transparent colors can be created using the "alpha" value: `UIColor.yellow.withAlphaComponent(0.5)`. The system needs to know of this by setting `var opaque = false` on the view. The entire view can be set to transparent through `var alpha: CGFloat`. Transparency is not cheap, so use it wisely.

### Drawing Text

To draw an immutable/non-changing string:

```swift
let text = NSAttributedString(string: "hello")
text.draw(at: aCGPoint)
let textSize: CGSize = text.size
```

For a mutable string:

```swift
let mutableText = NSMutableAttributedString(string: "some string")
```

Set or add attributes by (Warning: this is a pre-Swift API):

```swift
func setAttributes(...)
func addAttributes(...)

NSForegroundColorAttributeName: UIColor
NSStrokeWidthAttributeName: CGFloat
NSFontAttributeName: UIFont

// ...and many others under UIKit!
```

Best way to get the preferred font:

```swift
static func preferredFont(forTextStyle: UIFontTextStyle) -> UIFont

// Example styles
UIFontTextStyle.headline
UIFontTextStyle.body
UIFontTextStyle.footnote
```

System fonts are used for things like buttons. Do not use them for user's content:

```swift
static func systemFont(ofSize: CGFloat)
static func boldSystemFont(ofSize: CGFloat)
```

### Drawing Images

```swift
let image: UIImage? = UIImage(named: "foo")

image.draw(atPoint: aCGPoint) // at defined size
image.draw(inRect: aCGRect) // scale to fit
image.drawAsPattern(inRect: aCGRect) // tile it
```

Note the image is an Optional as it may not be found. Add `foo.jpg` to your project in the Images.xcassets file. Images can also be initialized from a file via contents or raw data.
