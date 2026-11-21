import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const TipPage(),
    );
  }
}

// Parse the bill amount.
double? parseBill(String input) => double.tryParse(input.trim());

// Calculate the tip and total.
({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;

  return (
    tip: tip,
    total: bill + tip,
  );
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController =
      TextEditingController();

  int _selectedPercent = 15;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(_billController.text);

    final result = bill != null && bill.isFinite && bill >= 0
        ? computeTip(bill, _selectedPercent)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(height: 20),

            const Text(
              'Calculate Your Tip',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Bill Amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _billController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixText: '₱ ',
                hintText: 'Enter bill amount',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Select Tip Percentage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment<int>(
                  value: 10,
                  label: Text('10%'),
                ),
                ButtonSegment<int>(
                  value: 15,
                  label: Text('15%'),
                ),
                ButtonSegment<int>(
                  value: 20,
                  label: Text('20%'),
                ),
              ],
              selected: {_selectedPercent},
              onSelectionChanged: (Set<int> selection) {
                setState(() {
                  _selectedPercent = selection.first;
                });
              },
            ),

            const SizedBox(height: 35),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Calculation Results',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (result == null)
                      const Text(
                        'Enter a valid amount',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      )
                    else ...[
                      Text(
                        'Tip: ₱${result.tip.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Total: ₱${result.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}