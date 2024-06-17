class ServiceItem {
  String service_name;
  String price;
  ServiceItem({required this.service_name, required this.price});
}

List<ServiceItem> baseService = [
  ServiceItem(service_name: "출장비", price: "2만원 ~ 5만원"),
  ServiceItem(service_name: "제품 분해·조립비", price: "7만원"),
];
//ServiceItem(service_name: "위험 수당", price: "7만원 ~ 10만원"),
