import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ufersa_hub/core/purchase/app_signature.dart';

class AssinaturaPage extends StatefulWidget {
  @override
  _AssinaturaPageState createState() => _AssinaturaPageState();
}

class _AssinaturaPageState extends State<AssinaturaPage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _available = false;
  List<ProductDetails> _products = [];

  final Set<String> _kIds = {
    AppSignature.noAds.name.camelToSnakeCase,
  }; // Substitua pelo ID da sua assinatura

  @override
  void initState() {
    super.initState();
    _initStoreInfo();
    _inAppPurchase.purchaseStream.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    });
  }

  Future<void> _initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) return;

    final ProductDetailsResponse response = await _inAppPurchase
        .queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      print('Produto não encontrado: ${response.notFoundIDs}');
    }

    setState(() {
      _available = isAvailable;
      _products = response.productDetails;
    });
  }

  void _comprar(ProductDetails produto) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: produto);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    ); // Para assinatura também
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (final PurchaseDetails purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        // 🔒 Aqui você pode liberar os recursos pagos
        print('Assinatura comprada com sucesso!');

        // Importante: reconhecer a compra
        _inAppPurchase.completePurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        print('Erro na compra: ${purchase.error}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) {
      return Center(child: Text('Loja não disponível'));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Assinar')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: Text(product.price),
            onTap: () => _comprar(product),
          );
        },
      ),
    );
  }
}



