abstract class MultiLanguage<T> {
  T? fa;
  T? ar;
  T? en;
}

mixin MultiLanguageMixin<T> on MultiLanguage<T> {
  T? tr() => fa ?? en ?? ar;
}
