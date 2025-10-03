import 'dart:core';

import 'package:flutter/material.dart';
import 'package:wildsnap/services/api_service.dart';

class RandomCatfact extends StatefulWidget {
  const RandomCatfact({super.key});

  @override
  State<RandomCatfact> createState() => _RandomCatfactState();
}

class _RandomCatfactState extends State<RandomCatfact> {
  String? _fact;
  bool _isLoading = false;
  String? _error;

  Future<void> _loadRandomFact() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final catFact = await fetchCatFacts();
      setState(() {
        _fact = catFact.fact;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRandomFact(); // charge l'api au démarrage
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _error != null
            ? Text('Erreur : $_error', style: TextStyle(color: Colors.red))
            : _fact != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 4,
              color: Colors.amber[200],
              child: Container(
                width: 600, // largeur fixe pour empêcher les sauts
                height: 170, // hauteur fixe ou maximum
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _fact!,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _loadRandomFact,
                      icon: Icon(Icons.refresh),
                      label: Text('Another fact'),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.green[800]!),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : Text('Aucun fait trouvé'),
      ),
    );
  }
}
