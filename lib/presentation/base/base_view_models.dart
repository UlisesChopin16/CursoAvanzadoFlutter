abstract class BaseViewModels extends BaseViewModelInputs{
  // shared variables and functions thah will be used throughout any view model
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model
  void dispose(); // will be called while disposing of view model
}

abstract class BaseViewModelOutputs {}
