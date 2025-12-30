import 'package:flutter/material.dart';
import 'package:range_indicators/logic/range_notifier.dart';
import 'package:range_indicators/ui/range_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RangeNotifier _notifier = RangeNotifier();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notifier.featchRanges();
  }

  @override
  void dispose() {
    _notifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Range Bar'),
      ),
      body: AnimatedBuilder(
          animation: _notifier,
          builder: (context, _) {
            if (_notifier.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (_notifier.errorMessage != null) {
              return _buildError();
            }

            return _buildContent();
          }),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_notifier.errorMessage!),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: _notifier.featchRanges,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets. bottom + 16,
          ),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter value',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final parsed = double.tryParse(value);

                  if (parsed != null) {
                    _notifier.updateInputValue(parsed);
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              RangeBar(ranges: _notifier.ranges, inputValue: _notifier.inputValue),
              if(_notifier.outOfRangeMessage !=null)...[
                const SizedBox(height: 8,),
                Text(
                 _notifier.outOfRangeMessage!,
                 style: const TextStyle(
                   color: Colors.redAccent,
                   fontSize: 15,
                 ),
                )
              ],
              const SizedBox(height: 16),
              _buildLegend(),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _notifier.ranges.map((range) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                color: range.color,
              ),
              const SizedBox(width: 8),
              Text(
                '${range.min.toInt()} - ${range.max.toInt()} : ${range.label}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }


}
