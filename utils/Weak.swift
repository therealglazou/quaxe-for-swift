public class Weak<T: AnyObject> {
  public weak var value : T?
  public init (_ value: T) {
    self.value = value
  }
}
