import 'package:flutter/material.dart';
import 'package:flutter_start/models/product.dart';
import 'package:flutter_start/services/product_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Future<List<Product>> _productsFuture = ProductService.getProducts();
  final Map<int, int> _quantities = <int, int>{};
  final Set<int> _savedForLater = <int>{};
  final TextEditingController _promoController = TextEditingController();
  String? _selectedCategory;
  String _productQuery = '';
  bool _promoApplied = false;
  bool _expressDelivery = false;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _addProduct(Product product) {
    setState(() {
      _quantities.update(
        product.id,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
    });
  }

  void _decreaseProduct(Product product) {
    setState(() {
      final quantity = _quantities[product.id] ?? 0;
      if (quantity <= 1) {
        _quantities.remove(product.id);
      } else {
        _quantities[product.id] = quantity - 1;
      }
    });
  }

  void _toggleSaved(Product product) {
    setState(() {
      if (_savedForLater.contains(product.id)) {
        _savedForLater.remove(product.id);
      } else {
        _savedForLater.add(product.id);
        _quantities.remove(product.id);
      }
    });
  }

  void _applyPromo() {
    final isValid = _promoController.text.trim().toUpperCase() == 'WELCOME10';
    setState(() => _promoApplied = isValid);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isValid ? '10% welcome discount applied' : 'Try code WELCOME10',
        ),
      ),
    );
  }

  void _checkout() {
    if (_quantities.isEmpty) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order ready'),
        content: Text(
          'Your ${_itemCount == 1 ? 'item is' : 'items are'} ready for checkout.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue shopping'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirm order'),
          ),
        ],
      ),
    );
  }

  int get _itemCount =>
      _quantities.values.fold(0, (sum, quantity) => sum + quantity);

  List<Product> _filterProducts(List<Product> products) {
    return products.where((product) {
      final matchesCategory =
          _selectedCategory == null || product.category == _selectedCategory;
      final matchesQuery =
          _productQuery.isEmpty ||
          product.title.toLowerCase().contains(_productQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Widget _image(Product product, {double size = 72}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        product.thumbnail,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: const Color(0xFFFFE5C2),
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: Color(0xFFB45309),
          ),
        ),
      ),
    );
  }

  Widget _quantityControl(Product product) {
    final quantity = _quantities[product.id] ?? 0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _decreaseProduct(product),
            icon: const Icon(Icons.remove, size: 16),
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => _addProduct(product),
            icon: const Icon(Icons.add, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _cartSection(List<Product> products) {
    final cartProducts = products
        .where((product) => (_quantities[product.id] ?? 0) > 0)
        .toList();
    if (cartProducts.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 48,
              color: Color(0xFFE59535),
            ),
            SizedBox(height: 10),
            Text(
              'Your bag is waiting',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              'Add something you love from the collection below.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: cartProducts.map((product) {
        final quantity = _quantities[product.id]!;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              _image(product),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${(product.price * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFFB45309),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _quantityControl(product),
                  TextButton(
                    onPressed: () => _toggleSaved(product),
                    child: const Text(
                      'Save for later',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _summaryRow(String label, String value, {bool prominent = false}) {
    final style = TextStyle(
      color: Colors.white,
      fontWeight: prominent ? FontWeight.bold : FontWeight.normal,
      fontSize: prominent ? 19 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE59535)),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Could not load products.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final products = snapshot.data ?? <Product>[];
        final categories = products
            .map((product) => product.category)
            .toSet()
            .toList();
        final filteredProducts = _filterProducts(products);
        final cartTotal = products
            .where((product) => _quantities.containsKey(product.id))
            .fold<double>(
              0,
              (sum, product) =>
                  sum + product.price * (_quantities[product.id] ?? 0),
            );
        final subtotal = cartTotal;
        final delivery = _expressDelivery
            ? 12.0
            : (_itemCount == 0 ? 0.0 : 5.0);
        final discount = _promoApplied ? subtotal * .1 : 0.0;
        final total = subtotal + delivery - discount;

        return Container(
          color: const Color(0xFFF7F3ED),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your bag',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Curated picks, ready to go',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFFE5C2),
                    child: Text(
                      '$_itemCount',
                      style: const TextStyle(
                        color: Color(0xFF9A5510),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _cartSection(products),
              const SizedBox(height: 14),
              TextField(
                controller: _promoController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Promo code',
                  suffixIcon: TextButton(
                    onPressed: _applyPromo,
                    child: const Text('Apply'),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Express delivery'),
                subtitle: const Text('Get it sooner for \$12.00'),
                value: _expressDelivery,
                onChanged: (value) => setState(() => _expressDelivery = value),
              ),
              _summaryWithTotal(total, subtotal, delivery, discount),
              const SizedBox(height: 28),
              const Text(
                'Keep exploring',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() => _productQuery = value),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: _selectedCategory == null,
                      onSelected: (_) =>
                          setState(() => _selectedCategory = null),
                    ),
                    ...categories.map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (_) =>
                              setState(() => _selectedCategory = category),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 218,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    final inCart = (_quantities[product.id] ?? 0) > 0;
                    return Container(
                      width: 164,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _image(product, size: 92),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB45309),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _addProduct(product),
                                icon: Icon(
                                  inCart
                                      ? Icons.add_circle
                                      : Icons.add_circle_outline,
                                  color: const Color(0xFFE59535),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _summaryWithTotal(
    double total,
    double subtotal,
    double delivery,
    double discount,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF20201E),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          _summaryRow(
            'Delivery',
            delivery == 0 ? 'Free' : '\$${delivery.toStringAsFixed(2)}',
          ),
          _summaryRow('Discount', '-\$${discount.toStringAsFixed(2)}'),
          const Divider(color: Colors.white24, height: 26),
          _summaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            prominent: true,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _itemCount == 0 ? null : _checkout,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFFB454),
                foregroundColor: Colors.black,
              ),
              child: const Text('Proceed to checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
