abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model.
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of the view model

  void dispose(); // will be called when view model dies
}

abstract class BaseViewModelOutputs {}
