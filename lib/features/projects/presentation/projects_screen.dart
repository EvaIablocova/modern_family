// lib/features/projects/presentation/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/widgets/footer_nav.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text('Lists'),
              subtitle: const Text('Grocery List and more'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GroceryListScreen()),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: const Text('Recipes'),
              subtitle: const Text('Create and manage recipes'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RecipesScreen()),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterNav(index: 3),
    );
  }
}

// Simple in-memory shared stores for demo purposes
class GroceryItem {
  GroceryItem({
    required this.id,
    required this.name,
    this.comment,
    this.imageUrl,
    this.checked = false,
  });
  final String id;
  final String name;
  String? comment;
  String? imageUrl;
  bool checked;
}

class GroceryStore {
  static final List<GroceryItem> items = <GroceryItem>[];

  static const List<String> baseProducts = [
    'Milk', 'Eggs', 'Bread', 'Butter', 'Cheese', 'Tomatoes', 'Onions', 'Potatoes', 'Chicken', 'Beef',
    'Rice', 'Pasta', 'Olive Oil', 'Salt', 'Pepper', 'Garlic', 'Apples', 'Bananas', 'Yogurt', 'Coffee',
  ];

  static void addItem(String name) {
    final exists = items.any((i) => i.name.toLowerCase() == name.toLowerCase());
    if (!exists) {
      items.add(GroceryItem(id: DateTime.now().microsecondsSinceEpoch.toString(), name: name));
    }
  }

  static void addItemsIfMissing(Iterable<String> names) {
    for (final n in names) {
      addItem(n);
    }
  }

  static void toggle(String id, bool v) {
    final i = items.indexWhere((e) => e.id == id);
    if (i != -1) items[i].checked = v;
  }

  static void update(String id, {String? comment, String? imageUrl}) {
    final i = items.indexWhere((e) => e.id == id);
    if (i != -1) {
      items[i].comment = comment;
      items[i].imageUrl = imageUrl;
    }
  }

  static void remove(String id) {
    items.removeWhere((e) => e.id == id);
  }
}

class Recipe {
  Recipe({required this.id, required this.name, required this.ingredients});
  final String id;
  final String name;
  final List<String> ingredients;
}

class RecipeStore {
  static final List<Recipe> recipes = <Recipe>[
    Recipe(id: 'r1', name: 'Pasta Carbonara', ingredients: ['Pasta', 'Eggs', 'Cheese', 'Pepper', 'Butter']),
    Recipe(id: 'r2', name: 'Chicken Curry', ingredients: ['Chicken', 'Onions', 'Garlic', 'Rice']),
  ];

  static void addRecipe(String name, List<String> ingredients) {
    recipes.add(Recipe(id: DateTime.now().microsecondsSinceEpoch.toString(), name: name, ingredients: ingredients));
  }
}

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _addFromInput() {
    final name = _ctrl.text.trim();
    if (name.isEmpty) return;
    setState(() => GroceryStore.addItem(name));
    _ctrl.clear();
  }

  Future<void> _editItem(GroceryItem item) async {
    final commentCtrl = TextEditingController(text: item.comment ?? '');
    final imageCtrl = TextEditingController(text: item.imageUrl ?? '');
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit ${item.name}', style: Theme.of(ctx).textTheme.titleMedium),
                const SizedBox(height: 12),
                TextField(
                  controller: commentCtrl,
                  decoration: const InputDecoration(labelText: 'Comment', border: OutlineInputBorder()),
                  minLines: 1,
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: imageCtrl,
                  decoration: const InputDecoration(labelText: 'Picture URL', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {
                      setState(() => GroceryStore.update(item.id, comment: commentCtrl.text.trim().isEmpty ? null : commentCtrl.text.trim(), imageUrl: imageCtrl.text.trim().isEmpty ? null : imageCtrl.text.trim()));
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    commentCtrl.dispose();
    imageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery List')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  decoration: const InputDecoration(
                    labelText: 'Add an item',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addFromInput(),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(onPressed: _addFromInput, icon: const Icon(Icons.add), label: const Text('Add')),
            ],
          ),
          const SizedBox(height: 16),
          Text('Quick add', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: GroceryStore.baseProducts.map((p) {
              return ActionChip(
                label: Text(p),
                onPressed: () => setState(() => GroceryStore.addItem(p)),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          if (GroceryStore.items.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(child: Text('No items yet')),
            )
          else
            ...GroceryStore.items.map((item) {
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: item.checked,
                    onChanged: (v) => setState(() => GroceryStore.toggle(item.id, v ?? false)),
                  ),
                  title: Text(item.name),
                  subtitle: item.comment == null || item.comment!.isEmpty ? null : Text(item.comment!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.imageUrl!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image_outlined),
                            ),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _editItem(item),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => setState(() => GroceryStore.remove(item.id)),
                        tooltip: 'Remove',
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  Future<void> _createRecipe() async {
    final nameCtrl = TextEditingController();
    final customIngredientCtrl = TextEditingController();
    final Set<String> selected = <String>{};

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New Recipe', style: Theme.of(ctx).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Recipe name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  Text('Ingredients (choose from base)', style: Theme.of(ctx).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: GroceryStore.baseProducts.map((p) {
                      final isSel = selected.contains(p);
                      return FilterChip(
                        label: Text(p),
                        selected: isSel,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              selected.add(p);
                            } else {
                              selected.remove(p);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: customIngredientCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Add custom ingredient',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) {
                            final n = customIngredientCtrl.text.trim();
                            if (n.isNotEmpty) {
                              setState(() {
                                selected.add(n);
                                customIngredientCtrl.clear();
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          final n = customIngredientCtrl.text.trim();
                          if (n.isNotEmpty) {
                            setState(() {
                              selected.add(n);
                              customIngredientCtrl.clear();
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: () {
                        final name = nameCtrl.text.trim();
                        if (name.isEmpty || selected.isEmpty) return;
                        RecipeStore.addRecipe(name, selected.toList());
                        Navigator.of(ctx).pop();
                        setState(() {});
                      },
                      child: const Text('Create'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

    nameCtrl.dispose();
    customIngredientCtrl.dispose();
  }

  void _addToGrocery(Recipe r) {
    setState(() {
      GroceryStore.addItemsIfMissing(r.ingredients);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ${r.ingredients.length} ingredient(s) to Grocery List')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createRecipe,
        icon: const Icon(Icons.add),
        label: const Text('New recipe'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (RecipeStore.recipes.isEmpty)
            const Center(child: Text('No recipes yet'))
          else
            ...RecipeStore.recipes.map((r) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.restaurant_menu_outlined),
                    title: Text(r.name),
                    subtitle: Text(r.ingredients.join(', ')),
                    trailing: TextButton.icon(
                      onPressed: () => _addToGrocery(r),
                      icon: const Icon(Icons.playlist_add_outlined),
                      label: const Text('Add to Grocery'),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
