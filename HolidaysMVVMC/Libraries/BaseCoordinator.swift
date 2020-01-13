import RxSwift

class BaseCoordinator<ResultType>: NSObject {

    typealias CoordinationResult = ResultType

    let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    @discardableResult
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator) })
    }

    func start() -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
}

