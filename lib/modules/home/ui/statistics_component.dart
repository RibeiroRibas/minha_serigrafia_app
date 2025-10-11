import 'package:flutter/material.dart';

class StatisticsComponent extends StatelessWidget {
  const StatisticsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Estatísticas', style: Theme.of(context).textTheme.titleLarge),
        Divider(),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produção', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Hoje: ', style: Theme.of(context).textTheme.bodyLarge),
                Text('5', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Text(
                  'Essa semana: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('20', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Text(
                  'Esse mês: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('45', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estampas', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Totais: ', style: Theme.of(context).textTheme.bodyLarge),
                Text('500', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Text(
                  'Novas nesse mês: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('20', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Matrizes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Totais: ', style: Theme.of(context).textTheme.bodyLarge),
                Text('500', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Text(
                  'Novos registros nesse mês: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('20', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clientes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text('Totais: ', style: Theme.of(context).textTheme.bodyLarge),
                Text('500', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Text(
                  'Novos nesse mês: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text('20', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
