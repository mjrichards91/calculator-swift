# Swift Learning

## Constant

```swift
let maximumNumberOfLoginAttempts = 10 
```

Helpful to let the reader & Swift know this value is never going to change. This holds true for arrays and dictionaries as well. This makes the actual code perform more efficiently.

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

Declarations with a `!` automagically unwraps the optional value as the `?` does not. 

## UI

`UILabel?` or `UILabel!` is optional so that iOS has time to connect the UI to the property

## Conventions

Clarity over brevity!

Semicolons are NOT required but are if multiple statements are on a single line:

```swift
let cat = “cat"; print(cat)
```

## Properties

All properties must be initialized unless they are optionals. Behind the scenes, optionals are set to `nil`

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
