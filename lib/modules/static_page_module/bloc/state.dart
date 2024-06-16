abstract class CommonPageState {
  CommonPageState();
}

class InitPageState extends CommonPageState {
  InitPageState();
}

class StaticPageState extends CommonPageState {
  String data;

  StaticPageState(this.data);
}
