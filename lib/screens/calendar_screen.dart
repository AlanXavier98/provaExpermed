import 'package:flutter/material.dart';
import 'package:prova_expermed/colors/app_colors.dart';
import 'package:prova_expermed/components/calendar_components/hour_name_widget.dart';
import 'package:prova_expermed/data/models/login_model.dart';
import 'package:prova_expermed/screens/cadastro_alteracao_consulta_screen.dart';
import 'package:prova_expermed/screens/info_person.dart';
import 'package:prova_expermed/services/shared_service.dart';
import 'package:table_calendar/table_calendar.dart';

// Esta tela exibirá o calendário e indicará os dias em que a pessoa possui ou não possui agendamentos.
// Como os dados estão mockados, está marcando que todos os dias não possuem agendamento.
// Para mudar de tela, basta clicar nos ícones de clientes na parte inferior da tela.

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime today = DateTime.now();
  SharedPref sharedPref = SharedPref();
  LoginModel? user;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "Olá, ${user?.name ?? 'Usuário'}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add), // Ícone de adição
                  onPressed: () {
                    // Ao pressionar o botão de adição, navegue para a tela de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroAlteracaoConsultaScreen(
                                user: user,
                                label: 'Cadastro',
                              )),
                    );
                  },
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Agenda",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  TableCalendar(
                    // locale: 'pt_BR', //Traduzindo os meses
                    focusedDay: today,
                    firstDay: DateTime.utc(2010, 5, 22),
                    lastDay: DateTime.utc(2030, 5, 22),
                    startingDayOfWeek: StartingDayOfWeek
                        .monday, //Indica que o primeiro dia do calendário é segunda
                    pageJumpingEnabled: true,

                    //Alterando nomes padrão de month, week e twoWeeks
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Mês',
                      CalendarFormat.week: 'Semana',
                      CalendarFormat.twoWeeks: '2 Semanas'
                    },
                    //Visualizar os nomes da semana
                    daysOfWeekVisible: true,
                    //Espaço entre os nomes das semana e a tabela
                    daysOfWeekHeight: 20.0,
                    //retirar ou nao o header(mes ano e as setas para trocar de mes)
                    headerVisible: true,

                    //Aplicando estilo no calendário
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible:
                          false, //Oculta os dias posteriores ao último dia do mês.
                      //Cor do dia selecionado
                      selectedDecoration: BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                      //Style do texto selecionado
                      selectedTextStyle:
                          TextStyle(color: Color.fromRGBO(238, 230, 226, 1)),
                      //Cor do dia de hoje
                      todayDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      //Texto do dia de hoje
                      todayTextStyle: TextStyle(color: AppColors.textColor),

                      //texto dos dias de semana
                      defaultTextStyle: TextStyle(color: AppColors.textColor),
                      //Cor da box dos fins de semana
                      weekendDecoration: BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.rectangle),
                      //texto dos dias de semana
                      weekendTextStyle: TextStyle(color: AppColors.textColor),
                    ),

                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18.0,
                      ),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: AppColors.textColor,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: AppColors.textColor,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: AppColors.textColor,
                      ),
                    ),

                    calendarBuilders: CalendarBuilders(
                      //Trazindo a cor dos nomes do dia no header
                      dowBuilder: (context, day) {
                        String text;
                        if (day.weekday == DateTime.sunday) {
                          text = 'Dom';
                        } else if (day.weekday == DateTime.monday) {
                          text = 'Seg';
                        } else if (day.weekday == DateTime.tuesday) {
                          text = 'Ter';
                        } else if (day.weekday == DateTime.wednesday) {
                          text = 'Qua';
                        } else if (day.weekday == DateTime.thursday) {
                          text = 'Qui';
                        } else if (day.weekday == DateTime.friday) {
                          text = 'Sex';
                        } else if (day.weekday == DateTime.saturday) {
                          text = 'Sab';
                        } else {
                          text = 'Err';
                        }
                        return Center(
                          child: Text(
                            text,
                            style: TextStyle(color: AppColors.textColor),
                          ),
                        );
                      },

                      //Cor dos marcadores para os eventos..
                      markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                bottom: 2.0,
                                child: Container(
                                  height: 10.0,
                                  width: 10.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Positioned(
                            top: 13.0,
                            child: Container(
                              height: 5.0,
                              width: 5.0,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                HourName(
                  label: '17:00 - Pedro Pedroso',
                  deleteFunc: () {},
                  editFunc: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroAlteracaoConsultaScreen(
                              user: user, label: 'Alteração')),
                    );
                  },
                  func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoPerson(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
                HourName(
                  label: '17:00 - Pedro Pedroso',
                  deleteFunc: () {},
                  editFunc: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastroAlteracaoConsultaScreen(
                              user: user, label: 'Alteração')),
                    );
                  },
                  func: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoPerson(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getUser() async {
    final response = await sharedPref.read('login');
    if (response != null) {
      // Verifica se a resposta não é nula
      LoginModel loginModel = LoginModel.fromJson(response);
      setState(() {
        user = loginModel;
      });
    } else {
      // Trate o caso em que não há dados salvos com a chave 'login' ou os dados não são do tipo esperado, acabei tratando no widget mesmo
    }
  }
}
