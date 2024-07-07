List<Type> jsonListConverter<Type>(dynamic jsonList, Type Function(Map<String, dynamic> json) converter) {
  return (jsonList! as List<dynamic>).map((item) => converter(item)).toList();
}