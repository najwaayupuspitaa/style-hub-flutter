
import 'package:flutter/material.dart';
import '../models/product.dart';

const Color cream = Color(0xFFF5EFE7);
const Color beige = Color(0xFFE6D7C5);
const Color mocha = Color(0xFF806653);
const Color darkBrown = Color(0xFF302720);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';
  String searchText = '';

  final Map<Product, int> cart = {};

  final List<String> categories = [
    'All',
    'Men',
    'Women',
    'Shoes',
    'Accessories',
  ];

  // DATA PRODUK STYLE HUB
  final List<Product> products = [
    Product(
      name: 'Classic Casual Shirt',
      category: 'Men',
      price: '129.000',
      image:
          'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=700&auto=format&fit=crop&q=85',
      description:
          'Kemeja kasual dengan desain minimalis dan bahan nyaman untuk menunjang penampilan sehari-hari.',
    ),
    Product(
      name: 'Elegant Women Blazer',
      category: 'Women',
      price: '249.000',
      image:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=700&auto=format&fit=crop&q=85',
      description:
          'Blazer wanita dengan desain elegan yang cocok untuk tampilan formal maupun semi-formal.',
    ),
    Product(
      name: 'Basic White T-Shirt',
      category: 'Men',
      price: '89.000',
      image:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=700&auto=format&fit=crop&q=85',
      description:
          'Kaos putih basic dengan desain timeless dan mudah dipadukan dengan berbagai gaya.',
    ),
    Product(
      name: 'Denim Jacket',
      category: 'Women',
      price: '199.000',
      image:
          'https://images.unsplash.com/photo-1543076447-215ad9ba6923?w=700&auto=format&fit=crop&q=85',
      description:
          'Jaket denim bergaya modern untuk memberikan kesan casual dan stylish.',
    ),
    Product(
      name: 'Fashion Sneakers',
      category: 'Shoes',
      price: '299.000',
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=700&auto=format&fit=crop&q=85',
      description:
          'Sneakers modern yang nyaman digunakan dan cocok untuk melengkapi berbagai outfit.',
    ),
    Product(
      name: 'Classic Handbag',
      category: 'Accessories',
      price: '189.000',
      image:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=700&auto=format&fit=crop&q=85',
      description:
          'Tas dengan desain elegan dan minimalis untuk melengkapi penampilan sehari-hari.',
    ),
  ];

  // FILTER PRODUK
  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product.category == selectedCategory;

      final keyword = searchText.toLowerCase().trim();

      final matchesSearch =
          product.name.toLowerCase().contains(keyword) ||
          product.category.toLowerCase().contains(keyword);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get totalCartItems {
    return cart.values.fold(0, (total, quantity) => total + quantity);
  }

  int get totalFavoriteItems {
    return products.where((product) => product.isFavorite).length;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // FAVORIT
  void toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  }

  // TAMBAH KERANJANG
  void addToCart(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang'),
        backgroundColor: mocha,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // DETAIL PRODUK
  void showProductDetail(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: beige,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    product.image,
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 260,
                        color: beige,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: mocha,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  product.category,
                  style: const TextStyle(
                    color: mocha,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(
                    color: mocha,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Product Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    color: mocha,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      addToCart(product);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBrown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  // KERANJANG
  void showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return Padding(
              padding: const EdgeInsets.all(22),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Shopping Cart',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: cart.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 55,
                                    color: mocha,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Keranjang masih kosong',
                                    style: TextStyle(color: mocha),
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              children: cart.entries.map((entry) {
                                final product = entry.key;
                                final quantity = entry.value;

                                return Card(
                                  color: Colors.white,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            product.image,
                                            width: 65,
                                            height: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 65,
                                                height: 70,
                                                color: beige,
                                                child: const Icon(Icons.image),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: darkBrown,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Rp ${product.price}',
                                                style: const TextStyle(
                                                  color: mocha,
                                                ),
                                              ),
                                              Text(
                                                'Jumlah: $quantity',
                                                style: const TextStyle(
                                                  color: mocha,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            modalSetState(() {
                                              if (quantity > 1) {
                                                cart[product] = quantity - 1;
                                              } else {
                                                cart.remove(product);
                                              }
                                            });
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: mocha,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            modalSetState(() {
                                              cart[product] = quantity + 1;
                                            });
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            color: mocha,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),
                        Text(
                          '$totalCartItems barang',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mocha,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBrown,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Continue Shopping'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // FAVORIT
  void showFavorites() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            final favoriteProducts =
                products.where((product) => product.isFavorite).toList();

            return Padding(
              padding: const EdgeInsets.all(22),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Favorites ❤️',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: favoriteProducts.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 55,
                                    color: mocha,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Belum ada produk favorit',
                                    style: TextStyle(color: mocha),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: favoriteProducts.length,
                              itemBuilder: (context, index) {
                                final product = favoriteProducts[index];

                                return Card(
                                  color: Colors.white,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        product.image,
                                        width: 55,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 55,
                                            height: 60,
                                            color: beige,
                                            child: const Icon(Icons.image),
                                          );
                                        },
                                      ),
                                    ),
                                    title: Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: darkBrown,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Rp ${product.price}',
                                      style: const TextStyle(color: mocha),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          product.isFavorite = false;
                                        });
                                        modalSetState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBrown,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Continue Shopping'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: _buildHeader(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSearch(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                child: _buildBanner(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: _buildCategorySection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: _buildProductTitle(),
              ),
            ),
            if (filteredProducts.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(35),
                  child: Center(
                    child: Text(
                      'Produk tidak ditemukan.',
                      style: TextStyle(
                        color: mocha,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildProductCard(filteredProducts[index]);
                    },
                    childCount: filteredProducts.length,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STYLE HUB',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: darkBrown,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Discover your own style.',
                style: TextStyle(color: mocha, fontSize: 13),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: showFavorites,
              icon: const Icon(
                Icons.favorite_border,
                color: darkBrown,
                size: 27,
              ),
            ),
            if (totalFavoriteItems > 0)
              Positioned(
                right: 2,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$totalFavoriteItems',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: showCart,
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: darkBrown,
                size: 28,
              ),
            ),
            if (totalCartItems > 0)
              Positioned(
                right: 2,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: mocha,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$totalCartItems',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // SEARCH
  Widget _buildSearch() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search products or categories...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          prefixIcon: const Icon(Icons.search, color: mocha),
          suffixIcon: IconButton(
            onPressed: () {
              searchController.clear();
              setState(() {
                searchText = '';
              });
            },
            icon: const Icon(Icons.close, color: mocha),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // BANNER
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkBrown, mocha],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEW COLLECTION',
            style: TextStyle(
              color: beige,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Find Your\nPerfect Style',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Upgrade your look with STYLE HUB.',
            style: TextStyle(color: beige, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // KATEGORI
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkBrown,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: 9),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;

              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                selectedColor: darkBrown,
                backgroundColor: beige,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : darkBrown,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide.none,
              );
            },
          ),
        ),
      ],
    );
  }

  // JUDUL PRODUK
  Widget _buildProductTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Popular Products',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkBrown,
          ),
        ),
        Text(
          '${filteredProducts.length} items',
          style: const TextStyle(color: mocha, fontSize: 12),
        ),
      ],
    );
  }

  // KARTU PRODUK
  Widget _buildProductCard(Product product) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: mocha.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                InkWell(
                  onTap: () => showProductDetail(product),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: beige,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: mocha,
                            size: 35,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor:
                        Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => toggleFavorite(product),
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 19,
                        color: product.isFavorite
                            ? Colors.red
                            : darkBrown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: const TextStyle(color: mocha, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: darkBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Rp ${product.price}',
                        style: const TextStyle(
                          color: mocha,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => addToCart(product),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: darkBrown,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
