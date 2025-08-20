import 'dart:convert'; // Para jsonEncode e jsonDecode
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TelaHome());
}

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App SharedPreferences - Nome, Idade, Endereço, RG',
      home: const TelaApp(),
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
    );
  }
}

// Classe para representar a pessoa
class Pessoa {
  String nome;
  String idade;
  String endereco;
   String rg;

  Pessoa({
    required this.nome,
    required this.idade,
    required this.endereco,
    required this.rg,
  });

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'idade': idade,
        'endereco': endereco,
        'rg': rg,
      };

  factory Pessoa.fromJson(Map<String, dynamic> json) => Pessoa(
        nome: json['nome'],
        idade: json['idade'],
        endereco: json['endereco'],
        rg: json['rg'],
      );
}

class TelaApp extends StatefulWidget {
  const TelaApp({super.key});

  @override
  State<TelaApp> createState() => _TelaAppState();
}

class _TelaAppState extends State<TelaApp> {
  final _ctrlNome = TextEditingController();
  final _ctrlIdade = TextEditingController();
  final _ctrlEndereco = TextEditingController();
  final _ctrlRG = TextEditingController();

  List<Pessoa> _pessoas = [];

  static const String _kUsernames = 'usernames';

  @override
  void initState() {
    super.initState();
    _carregarPessoas();
  }

  @override
  void dispose() {
    _ctrlNome.dispose();
    _ctrlIdade.dispose();
    _ctrlEndereco.dispose();
    _ctrlRG.dispose();
    super.dispose();
  }

  Future<void> _salvarPessoa() async {
    final prefs = await SharedPreferences.getInstance();

    final nome = _ctrlNome.text.trim();
    final idade = _ctrlIdade.text.trim();
    final endereco = _ctrlEndereco.text.trim();
    final rg = _ctrlRG.text.trim();

    if (nome.isEmpty || idade.isEmpty || endereco.isEmpty || rg.isEmpty) {
      _snack('Preencha todos os campos!');
      return;
    }

    // Carrega a lista atual em JSON e converte para Pessoa
    final atuais = prefs.getStringList(_kUsernames) ?? [];

    final pessoasAtuais = atuais
        .map((e) => Pessoa.fromJson(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();

    // Verifica se já existe pessoa com esse nome
    if (pessoasAtuais.any((p) => p.nome.toLowerCase() == nome.toLowerCase())) {
      _snack('Esse nome já está na lista');
      return;
    }

    final novaPessoa = Pessoa(nome: nome, idade: idade, endereco: endereco, rg: rg);
    pessoasAtuais.add(novaPessoa);

    final listaJson =
        pessoasAtuais.map((p) => jsonEncode(p.toJson())).toList();

    await prefs.setStringList(_kUsernames, listaJson);

    setState(() {
      _pessoas = pessoasAtuais;
    });

    _ctrlNome.clear();
    _ctrlIdade.clear();
    _ctrlEndereco.clear();
    _ctrlRG.clear();

    _snack('Pessoa salva com sucesso!');
  }

  Future<void> _carregarPessoas() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getStringList(_kUsernames) ?? [];

    final pessoas = listaJson
        .map((e) => Pessoa.fromJson(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();

    setState(() => _pessoas = pessoas);
  }

  Future<void> _removerPessoa(Pessoa pessoa) async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getStringList(_kUsernames) ?? [];

    final pessoas = listaJson
        .map((e) => Pessoa.fromJson(Map<String, dynamic>.from(jsonDecode(e))))
        .toList();

    pessoas.removeWhere((p) => p.nome == pessoa.nome);

    final novaListaJson = pessoas.map((p) => jsonEncode(p.toJson())).toList();

    await prefs.setStringList(_kUsernames, novaListaJson);

    setState(() {
      _pessoas = pessoas;
    });

    _snack('Removido ${pessoa.nome}');
  }

  Future<void> _limparTudo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kUsernames);
    setState(() => _pessoas = []);
    _snack('Lista limpa!');
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App SharedPreferences - Nome, Idade, Endereço, RG'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Digite os dados abaixo',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrlNome,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrlIdade,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ctrlEndereco,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _salvarPessoa(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrlRG,
              decoration: const InputDecoration(
                labelText: 'RG',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _salvarPessoa(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _salvarPessoa,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _carregarPessoas,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Carregar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pessoas.isEmpty ? null : _limparTudo,
                    icon: const Icon(Icons.delete),
                    label: const Text('Limpar Tudo'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _pessoas.isEmpty
                  ? const Center(child: Text('Sem pessoas salvas'))
                  : ListView.separated(
                      itemCount: _pessoas.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, i) {
                        final pessoa = _pessoas[i];
                        return Dismissible(
                          key: ValueKey(pessoa.nome),
                          background: Container(
                            color: Colors.redAccent,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            color: Colors.redAccent,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) => _removerPessoa(pessoa),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                pessoa.nome.isNotEmpty
                                    ? pessoa.nome[0].toUpperCase()
                                    : '?',
                              ),
                            ),
                            title: Text(pessoa.nome),
                            subtitle:
                                Text('Idade: ${pessoa.idade} | Endereço: ${pessoa.endereco} | RG: ${pessoa.rg}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removerPessoa(pessoa),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Total: ${_pessoas.length}'),
            ),
          ],
        ),
      ),
    );
  }
}

