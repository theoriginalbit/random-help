import Foundation

class Observable<T> {
    private var value: T?
    private var handler: ((T) -> Void)?
    
    func accept(_ value: T) {
        self.value = value
        handler?(value)
    }
    
    func subscribe(_ handler: @escaping (T) -> Void) {
        self.handler = handler
        if let value = value {
            handler(value)
        }
    }
}
