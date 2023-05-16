# flutt原生路由相关

## 路由的作用
Flutter中的路由主要用于管理和导航屏幕之间的转换，实现多个页面之间的切换。它可以让用户在应用程序的不同页面之间自由切换，以达到用户期望的操作。在Flutter中，路由包括两种类型：`Navigator`和`PageRoute`。

`Navigator`是管理页面的栈式结构，它管理着当前页面和之前页面的层级关系。用户通过`Navigator.push()`方法从当前页面跳转到其他页面，通过`Navigator.pop()`方法返回上一个页面。还可以通过`Navigator.popUntil()`方法跳转到栈中的特定页面。

PageRoute则定义了页面的具体内容和动画效果。每个页面都有一个`PageRoute`对象，并可基于Flutter提供的`PageRouteBuilder`类创建自定义的`PageRoute`。`PageRoute`支持定义页面的转场动画，包括从左到右，从右到左，从上到下，从下到上等不同动画效果。

总之，路由是Flutter开发中必不可少的一部分，有助于构建具有多个页面和层次关系的应用程序。

## 路由的配置
在Flutter中使用MaterialApp可以设置不同的路由参数，以下是常用的路由参数：
|参数|作用|
|---|---|
|initialRoute|设置初始路由名称（字符串），该路由名称必须在`routes`映射表中注册。默认值为‘/’|
|routes| 定义路由表，用于管理应用内页面路由。该映射表必须包含key为字符串的路由名，和对应的`builder`方法返回值。当应用程序使用`Navigator.pushNamed`到达该路由时，将会调用该`builder`方法|
|onGenerateRoute| 可以对应用程序不在路由表中的请求进行自定义处理。通常用于构建动态路由，比如从服务器请求数据后展示页面|
|onUnknownRoute| 当应用程序尝试访问未注册的路由时，将会调用该方法。可以用于展示**自定义错误页面**或者默认的404页面|
|navigatorObservers| 自定义路由观察器，用于在路由转换时监控和记录。

综上，MaterialApp上的路由参数可以实现多种路由管理和自定义路由逻辑，非常灵活和方便。

⚠️PS:值得注意的是, 如果routes参数和home参数为互斥状态,只能选择其一

## 路由的分类

### 1. 静态路由 
静态路由指的是需要提前把各个需要跳转的页面路径注册在`routes: <String, WidgetBuilder> {}`中，且静态路由不支持向下一个页面传递参数，但是可以接收下一个页面的返回值.

### 如何使用
需要在`MaterialApp`中的`routes`中提前注册路由
```dart
MaterialApp(
        title: 'Flutter 原生测试',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        routes: <String, WidgetBuilder>{'router/new_page': (_) => const StaticNavigatorPage()});
```
**跳转路由**
```dart
Navigator.of(context).pushNamed('router/new_page').then((value) => null {};
```
使用`then`可以接受跳转路由关闭后传递回来的数据,返回`Object?`类型

⚠️PS: 这里的路由名要跟在`MaterialApp`中注册的路由名存在匹配项才可以跳转成功,否则将会抛出找不到路由的异常

**退出路由**
pop为`T?`类型
```dart
Navigator.of(context).pop('页面结束后返回的数据');
```

### 1. 动态路由
动态路由使用就相对来说比较灵活一点，动态路由同样支持向下一个页面传递参数，而且在使用时不需要我们提前规划好页面路径，只需要在具体跳页逻辑中自己去构造`MaterialPageRoute`对象来完成页面跳转，或者用`PageRouterBuilder`来自定义路由跳转时的动画.

### 如何使用
使用动态路由时我们不再需要像静态路由那样在`MaterialApp`中的`router`中提前注册路由路径，只需要在使用`Navigator.push`传入`MaterialPageRoute`对象即可

**跳转路由**
```dart
Navigator.push(
    context,
    MaterialPageRoute(
        //_代表参数为空
        builder: (_) => new DynamicNaviattionPage(
              xxx: "xxx",
            )));
```
**退出路由**
用法和静态路由退路由方法一致
```dart
Navigator.pop(context, "xxx");
```

在了解了如何使用基本的flutter路由后, 我们再回头来看看各个部分的详细信息吧.

#### Navigator参数
|参数|用途|特殊点|
|---|---|---|
|push| 将设置的router信息推送到Navigator上，实现页面跳转|
|of|主要是获取 Navigator最近的路由对象|
|maybeOf|主要是获取 Navigator最近的路由对象,获取不到时不会抛出异常|
|pop|退出当前路由页面|
|canPop|判断能否退出当前页面|
|maybePop |如果可以退出当前页面则退出,并返回true|
|popUntil |反复执行pop 直到该函数的参数`predicate`返回true为止|退出当前路由时,下层直接显示最后应该停止在的路由|
|popAndPushNamed |指定一个路由路径，并导航到新页面|旧路由退出时,同步出现新路由|
|pushNamed|将命名路由推送到Navigator|
|pushAndRemoveUntil |将给定路由推送到Navigator，删除除指定路由之外的所有路由|下层页面不动,等新路由完全出现后再删除除指定路由之外的所有路由|
|pushNamedAndRemoveUntil |原理和`pushAndRemoveUntil`,区别是使用路由名称操作|
|pushReplacement |路由替换|下层页面不动,等新路由完全出现后才完成替换|
|pushReplacementNamed |原理同`pushReplacement`,使用路由名称操作|
|removeRoute |从Navigator中删除路由，同时执行`Route.dispose`操作|
|removeRouteBelow |从Navigator中删除路由，同时执行`Route.dispose`操作，要替换的路由是传入参数`anchorRouter`里面的路由|
|replace |将Navigator中的路由替换成一个新路由|瞬间替换掉当前路由|
|replaceRouteBelow |将Navigator中的路由替换成一个新路由，要替换的路由是是传入参数`anchorRouter`里面的路由|
|defaultGenerateInitialRoutes|生成默认的路由|

在 Flutter 中，在路由方法名后添加 restorable 前缀，表示使用该方法推送的路由可以在应用程序关闭时保存其状态，并在应用程序再次启动时进行恢复，以便用户可以在恢复前关闭应用程序

值得注意的是,flutter似乎没有提供路由栈的功能,如果需要可以在监听路由的同时将路由对象保存起来,需要在`runApp`之前进行初始化后保存在全局变量

### 部分功能详解
#### navigatorObservers
对于flutter原生路由的生命周期,我们可以借助`navigatorObservers`来进行管理,下面先看一下其具有的方法
|参数|用途|
|---|---|
|didPush|添加了一个新路由到历史记录中|
|didPop|从历史记录中弹出当前路由|
|didRemove|从历史记录中移除了一个路由|
|didReplace|路由替换|
|didStartUserGesture|当用户开始操作新的路由时被调用，例如手势拖动等，触发了路由转换|
|didStopUserGesture|当用户结束操作新的路由时被调用|

