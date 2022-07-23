//
//  AsyncOperation.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import Foundation

/// Данный класс переопределяет Operation для работы с асинхронными операциями
open class AsyncOperation: Operation {

    /// Enum состояний асинхронной операции, создается для удобства управления состоянием этой операции.
    enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }

    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {

    /// Состояния операции по умолчанию get свойства, здесь мы их переопределяем для возможности управления ими
    override open var isReady: Bool {
        return super.isReady && state == .ready
    }

    override open var isExecuting: Bool {
        return state == .executing
    }

    override open var isFinished: Bool {
        return state == .finished
    }

    /// Для использования асинхронной операции, выставляем в true
    override open var isAsynchronous: Bool {
        return true
    }

    /// Всегда делаем проверку на завершение операции для изменения состояния
    override open func start() {
        if isCancelled {
            state = .finished
            return
        }

        main()
        state = .executing
    }

    open override func cancel() {
        super.cancel()
        state = .finished
    }
}

