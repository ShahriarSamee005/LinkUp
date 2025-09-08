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
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
              TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: "Description")),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
              TextField(controller: _imageUrlController, decoration: const InputDecoration(labelText: "Image URL")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Adapted to named parameters of GoodsDatabase.insertGoods
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
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
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
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: "Title")),
              TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: "Description")),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
              TextField(controller: _imageUrlController, decoration: const InputDecoration(labelText: "Image URL")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Adapted to named parameters of GoodsDatabase.updateGoods
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
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = authService.getCurrentUserUid();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Goods Page"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewGoods,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: goodsDb.goodsTable.stream(primaryKey: ['id']).eq('user_id', uid!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final goods = snapshot.data!;

          return ListView.builder(
            itemCount: goods.length,
            itemBuilder: (context, index) {
              final item = goods[index];
              final id = item['id'];

              return Card(
                child: ListTile(
                  title: Text(item['title'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['description'] ?? ''),
                      Text("Price: \$${item['price'] ?? ''}"),
                      Text("Image URL: ${item['image_url'] ?? ''}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
