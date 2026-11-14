// Modelos de Dominio para el Módulo de Inventario y Kardex de Azulito POS

enum InventoryMovementType {
  initial,
  purchase,
  sale,
  refund,
  adjustment,
  waste,
}

class InventoryMovementModel {
  final String id;
  final String storeId;
  final String productId;
  final String productName;
  final String movementType; // 'initial', 'purchase', 'sale', 'refund', 'adjustment', 'waste'
  final double quantity; // Positivo para entradas, negativo para salidas
  final double previousStock;
  final double newStock;
  final double unitCostUsd;
  final String? referenceId; // ID de factura, orden de compra o sesión
  final String? notes; // Motivo obligatorio en ajustes/mermas
  final String userName;
  final DateTime createdAt;

  InventoryMovementModel({
    required this.id,
    this.storeId = 'a0000000-0000-4000-8000-000000000001',
    required this.productId,
    required this.productName,
    required this.movementType,
    required this.quantity,
    required this.previousStock,
    required this.newStock,
    this.unitCostUsd = 0.0,
    this.referenceId,
    this.notes,
    this.userName = 'Cajero Principal',
    required this.createdAt,
  });

  bool get isPositive => quantity > 0;

  String get typeLabel {
    switch (movementType) {
      case 'purchase':
        return 'Compra / Entrada';
      case 'sale':
        return 'Venta POS';
      case 'refund':
        return 'Devolución de Venta';
      case 'adjustment':
        return 'Ajuste de Conteo';
      case 'waste':
        return 'Merma / Pérdida';
      case 'initial':
        return 'Inventario Inicial';
      default:
        return movementType;
    }
  }
}

class InventoryMetricsModel {
  final int totalSkus;
  final double totalCostUsd;
  final double totalRetailUsd;
  final double totalRetailBs;
  final int lowStockCount;

  InventoryMetricsModel({
    required this.totalSkus,
    required this.totalCostUsd,
    required this.totalRetailUsd,
    required this.totalRetailBs,
    required this.lowStockCount,
  });
}

