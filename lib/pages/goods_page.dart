import 'package:flutter/material.dart';
import 'package:link_up/Auth/aut_service.dart';
import 'package:link_up/db/goods_database.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  final goodsDb = GoodsDatabase();
  final authService = AuthService();

  void addNewGoods() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _imageUrlController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Goods"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await goodsDb.insertGoods(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  price: double.tryParse(_priceController.text) ?? 0.0,
                  imageUrl: _imageUrlController.text,
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Goods added successfully")),
                  );
                }
                Navigator.pop(context);
                setState(() {}); 
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void updateGoods(dynamic id, Map<String, dynamic> oldData) {
    _titleController.text = oldData['title'] ?? '';
    _descriptionController.text = oldData['description'] ?? '';
    _priceController.text = (oldData['price'] ?? '').toString();
    _imageUrlController.text = oldData['image_url'] ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Goods"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await goodsDb.updateGoods(
                  id: id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  price: double.tryParse(_priceController.text),
                  imageUrl: _imageUrlController.text,
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Goods updated successfully")),
                  );
                }
                Navigator.pop(context);
                setState(() {}); 
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void deleteGoods(dynamic id) async {
    try {
      await goodsDb.deleteGoods(id);
      if (mounted) {
        setState(() {}); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Goods deleted successfully")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUid  = authService.getCurrentUserUid();

    return Stack(
      children: [
        Positioned.fill(
          top: 80,
          child: StreamBuilder(
            stream: goodsDb.goodsTable.stream(primaryKey: ['id']),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final goods = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80), 
                itemCount: goods.length,
                itemBuilder: (context, index) {
                  final item = goods[index];
                  final id = item['id'];
                  final isOwner = item['user_id'] == currentUid ;


                  return Card(
                    color: Color.fromARGB(255, 88, 236, 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((item['image_url'] ?? '').isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item['image_url'],
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox(
                                    height: 150,
                                    child: Center(child: Text("Image not available")),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            item['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(item['description'] ?? ''),
                          const SizedBox(height: 4),
                          Text("Price: \$${item['price'] ?? ''}"),
                          if(isOwner)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => updateGoods(id, item),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => deleteGoods(id),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        const Positioned(
          top: -5,
          left: 20,
          right: 20,
          child: Center(
            child: Text(
              "Buy & Sell",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 88, 236, 130),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 22,
          right: 20,
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 17,
            shadowColor:  const Color.fromARGB(255,17,35,22),
            child: FloatingActionButton(
              onPressed: addNewGoods,
              backgroundColor: const Color.fromARGB(255, 88, 236, 130),
              foregroundColor: const Color.fromARGB(255,17,35,22),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
