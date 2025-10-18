import 'package:flutter/material.dart';
import 'package:minhaserigrafia/modules/company/model/company_statistics_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';

class StatisticsComponent extends StatelessWidget {
  final CompanyStatisticsModel companyStatistics;

  const StatisticsComponent({super.key, required this.companyStatistics});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text('Estatísticas:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16.0),
        PrimaryContainerComponent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Produção', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text('Hoje: ', style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    companyStatistics.production.totalToday,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Essa semana: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.production.totalThisWeek,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Esse mês: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.production.totalThisMonth,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        PrimaryContainerComponent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estampas', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Totais: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.print.total,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Novas nesse mês: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.print.totalThisMonth,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16.0),
        PrimaryContainerComponent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Matrizes', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Totais: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.frame.total,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Novos registros nesse mês: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.frame.totalThisMonth,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16.0),
        PrimaryContainerComponent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Clientes', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Totais: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.customer.total,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Novos nesse mês: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    companyStatistics.customer.totalThisMonth,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
