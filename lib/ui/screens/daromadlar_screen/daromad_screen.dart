import 'package:exem_6/blocs/daromad_bloc/daromad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaromadScreen extends StatefulWidget {
  const DaromadScreen({super.key});

  @override
  State<DaromadScreen> createState() => _DaromadScreenState();
}

class _DaromadScreenState extends State<DaromadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<DaromadBloc>().add(
                    AddDaromadEvent(
                      summa: 555,
                      category: "Qarz",
                      sana: "2024-10-25",
                      izoh: "Shunchaki",
                    ),
                  );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: BlocBuilder<DaromadBloc, DaromadState>(
        bloc: context.read<DaromadBloc>()..add(GetDaromadEvent(harjatlar: [])),
        builder: (context, state) {
          if (state is LoadingDaromadState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedDaromadState) {
            if (state.harajat.isEmpty) {
              return const Center(
                child: Text("Daromadlar Mavjud emas..."),
              );
            }
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("200"),
                  subtitle: Text("data"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
