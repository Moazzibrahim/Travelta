class ManualBookingData {
  String? selectedServiceId;
  String? selectedService;
  String? selectedSupplier;
  String? selectedcustomer;
  String? selectedcustomerId;
  String? fromselectedSupplierId;
  String? selectedCurrencyId;
  String? selectedCurrency;
  double cost = 0.0;
  String selectedMarkup = '';
  double markupValue = 0.0;
  double finalPrice = 0.0;
  String? selectedCountryId;
  String? selectedCountry;
  String? selectedCityId;
  String? selectedCity;
  String? selectedTaxId;
  String? selectedTax;
  String? selectedTaxType;
  String? selectedCategory;
  String? selectedtoSupplier;
  String? selectedtoSupplierId;
  String? selectedtoCustomer;
  String? selectedtoCustomerId;
  double selectedTaxAmount = 0.0;
  void calculateFinalPrice() {
    if (selectedMarkup == 'value') {
      finalPrice = cost + markupValue + selectedTaxAmount;
    } else if (selectedMarkup == 'precentage') {
      finalPrice = cost + (cost * (markupValue / 100)) + selectedTaxAmount;
    } else {
      finalPrice = cost + selectedTaxAmount;
    }
  }

  void setCost(double newCost) {
    if (newCost < 0) {
      throw ArgumentError("Cost cannot be negative.");
    }
    cost = newCost;
    calculateFinalPrice();
  }

  void setMarkupValue(double newMarkupValue) {
    if (newMarkupValue < 0) {
      throw ArgumentError("Markup value cannot be negative.");
    }
    markupValue = newMarkupValue;
    calculateFinalPrice();
  }

  @override
  String toString() {
    return '''
    Service: $selectedService
    Service ID: $selectedServiceId
    Supplier: $selectedSupplier
    Supplier ID: $fromselectedSupplierId
    Currency: $selectedCurrency
    Currency ID: $selectedCurrencyId
    Cost: $cost
    Markup: $selectedMarkup
    Markup Value: $markupValue
    Final Price: $finalPrice
    Country: $selectedCountry
    Country ID: $selectedCountryId
    Tax: $selectedTax
    Tax ID: $selectedTaxId
    Tax Type: $selectedTaxType
  ''';
  }
}
