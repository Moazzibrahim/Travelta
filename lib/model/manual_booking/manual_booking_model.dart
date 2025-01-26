class ManualBookingData {
  String? selectedServiceId;
  String? selectedService;
  String? selectedSupplier;

  String? selectedSupplierId;
  String? selectedCurrencyId;
  String? selectedCurrency;

  double cost = 0.0;
  String selectedMarkup = '';
  double markupValue = 0.0;
  double finalPrice = 0.0;
  String? selectedCountryId;
  String? selectedCountry;

  String? selectedTaxId;
  String? selectedTax;

  String? selectedTaxType;
  String? selectedCategory;
  String? selectedSupplierOrCustomer;

  void calculateFinalPrice() {
    if (selectedMarkup == '\$') {
      finalPrice = cost + markupValue;
    } else if (selectedMarkup == '%') {
      finalPrice = cost + (cost * (markupValue / 100));
    } else {
      finalPrice = cost;
    }
  }

  @override
  String toString() {
    return '''
    ManualBookingData:
    Service ID: $selectedServiceId
    Supplier ID: $selectedSupplierId
    Currency ID: $selectedCurrencyId
    Cost: $cost
    Markup: $selectedMarkup
    Markup Value: $markupValue
    Final Price: $finalPrice
    Country ID: $selectedCountryId
    Tax ID: $selectedTaxId
    Tax Type: $selectedTaxType
    Selected Category: $selectedCategory
    Selected Supplier/Customer: $selectedSupplierOrCustomer
    ''';
  }
}
