import 'package:flutter/material.dart';

void main() {
  runApp(EliComicsApp());
}

class EliComicsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eli-Comics',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  // Lista de secciones del menú superior
  final List<String> menuItems = [
    "Inicio",
    "Comics",
    "Empleados",
    "Tiendas",
    "Ventas",
    "Inventario",
    "Devoluciones",
    "Facturas"
  ];

  // Lista de productos (cómics)
  final List<Map<String, String>> products = [
    {
      "title": "Cómic 1",
      "image": "assets/co1.jpg",
      "details": "¡Una historia épica del Cómic 1!"
    },
    {
      "title": "Cómic 2",
      "image": "assets/co2.jpg",
      "details": "¡Una historia épica del Cómic 2!"
    },
    {
      "title": "Cómic 3",
      "image": "assets/co3.jpg",
      "details": "¡Una historia épica del Cómic 3!"
    },
    {
      "title": "Cómic 4",
      "image": "assets/co4.jpg",
      "details": "¡Una historia épica del Cómic 4!"
    },
    {
      "title": "Cómic 5",
      "image": "assets/co5.jpg",
      "details": "¡Una historia épica del Cómic 5!"
    },
    {
      "title": "Cómic 6",
      "image": "assets/co6.jpg",
      "details": "¡Una historia épica del Cómic 6!"
    },
  ];

  // Muestra el diálogo con los detalles del producto
  void showDialogProduct(BuildContext context, Map<String, String> product) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Icon(Icons.close),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Image.asset(product["image"]!, height: 200),
                SizedBox(height: 10),
                Text(
                  product["title"]!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(product["details"]!),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("¡Gracias por tu compra!")),
                    );
                  },
                  child: Text("Comprar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Muestra un mensaje de "en proceso" al pulsar una opción del menú
  void showEnProceso(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$section" en proceso')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eli-Comics"), backgroundColor: Colors.cyan),
      body: Column(
        children: [
          // Menú superior adaptado para que todas las opciones se vean al mismo tiempo
          Container(
            color: Colors.cyan[100],
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              alignment: WrapAlignment.center,
              children: menuItems.map((item) {
                return TextButton(
                  onPressed: () => showEnProceso(context, item),
                  child: Text(item, style: TextStyle(fontSize: 14)),
                );
              }).toList(),
            ),
          ),

          // Sección de productos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2, // Solo 2 productos por fila (más grandes)
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: products.map((product) {
                  return GestureDetector(
                    onTap: () => showDialogProduct(context, product),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Image.asset(
                                product["image"]!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              product["title"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
