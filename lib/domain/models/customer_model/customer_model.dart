class CustomerModel {
  final String id;
  final String name;
  final String apellidoP;
  final String apellidoM;
  final int numOfNotifications;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.apellidoP,
    required this.apellidoM,
    required this.numOfNotifications,
  });
}