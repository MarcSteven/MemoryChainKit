### Coding only
```Swift
struct MenuItem1: MenuItemViewCustomizable {}
struct MenuItem2: MenuItemViewCustomizable {}

struct MenuOptions: MenuViewCustomizable {
    var itemsOptions: [MenuItemViewCustomizable] {
        return [MenuItem1(), MenuItem2()]
    }
}

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [UIViewController(), UIViewController()])
    }
}

let options = PagingMenuOptions()
let pagingMenuController = PagingMenuController(options: options)

addChildViewController(pagingMenuController)
view.addSubview(pagingMenuController.view)
pagingMenuController.didMove(toParentViewController: self)
```


### Menu move handler (optional)

```Swift
public enum MenuMoveState {
    case willMoveController(to: UIViewController, from: UIViewController)
    case didMoveController(to: UIViewController, from: UIViewController)
    case willMoveItem(to: MenuItemView, from: MenuItemView)
    case didMoveItem(to: MenuItemView, from: MenuItemView)
    case didScrollStart
    case didScrollEnd
}

pagingMenuController.onMove = { state in
    switch state {
    case let .willMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .didMoveController(menuController, previousMenuController):
        print(previousMenuController)
        print(menuController)
    case let .willMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case let .didMoveItem(menuItemView, previousMenuItemView):
        print(previousMenuItemView)
        print(menuItemView)
    case .didScrollStart:
        print("Scroll start")
    case .didScrollEnd:
        print("Scroll end")
    }
}
```

### Moving to a menu tag programmatically

```swift
// if you pass a nonexistent page number, it'll be ignored
pagingMenuController.move(toPage: 1, animated: true)
```

### Changing PagingMenuController's option

Call `setup` method with new options again.
It creates a new paging menu controller. Do not forget to cleanup properties in child view controller.
