import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieManagementScreen extends StatefulWidget {
  const MovieManagementScreen({Key? key}) : super(key: key);

  @override
  _MovieManagementScreenState createState() => _MovieManagementScreenState();
}

class _MovieManagementScreenState extends State<MovieManagementScreen> {
  List<dynamic> movies = [];
  bool _isLoading = false;
  final String _apiUrl = 'http://10.0.2.2:3000/movies'; // Certifique-se de que o endereço IP está correto
  final http.Client _client = http.Client();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _posterUrlController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _trailerUrlController = TextEditingController();
  final List<TextEditingController> _genreControllers = [TextEditingController()];
  bool _isNowPlaying = false;
  bool _isPopular = false;
  dynamic _editingMovieId;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() => _isLoading = true);
    try {
      final response = await _client.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        if (decodedData is List) {
          setState(() => movies = decodedData);
        } else {
          _showError("Formato de resposta da API incorreto");
        }
      } else {
        _showError("Erro ao carregar filmes: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Erro ao carregar filmes: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _addMovie() async {
    if (_titleController.text.isEmpty) {
      _showError("O título é obrigatório");
      return;
    }

    setState(() => _isLoading = true);
    try {
      List<String> genres = _genreControllers
          .map((controller) => controller.text.trim())
          .where((genre) => genre.isNotEmpty)
          .toList();

      final response = await _client.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _titleController.text,
          'posterUrl': _posterUrlController.text,
          'rating': _ratingController.text.isNotEmpty
              ? double.parse(_ratingController.text)
              : 0,
          'duration': _durationController.text,
          'genres': genres,
          'overview': _overviewController.text,
          'trailerUrl': _trailerUrlController.text,
          'isNowPlaying': _isNowPlaying,
          'isPopular': _isPopular,
        }),
      );

      if (response.statusCode == 201) {
        _fetchMovies();
        _clearForm();
        _showSuccess("Filme adicionado com sucesso!");
      } else {
        _showError("Erro ao adicionar filme: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Erro ao adicionar filme: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateMovie(dynamic id) async {
    if (_titleController.text.isEmpty) {
      _showError("O título é obrigatório");
      return;
    }

    setState(() => _isLoading = true);
    try {
      List<String> genres = _genreControllers
          .map((controller) => controller.text.trim())
          .where((genre) => genre.isNotEmpty)
          .toList();

      final response = await _client.put(
        Uri.parse('$_apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _titleController.text,
          'posterUrl': _posterUrlController.text,
          'rating': _ratingController.text.isNotEmpty
              ? double.parse(_ratingController.text)
              : 0,
          'duration': _durationController.text,
          'genres': genres,
          'overview': _overviewController.text,
          'trailerUrl': _trailerUrlController.text,
          'isNowPlaying': _isNowPlaying,
          'isPopular': _isPopular,
        }),
      );

      if (response.statusCode == 200) {
        _fetchMovies();
        _clearForm();
        _showSuccess("Filme atualizado com sucesso!");
      } else {
        _showError("Erro ao atualizar filme: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Erro ao atualizar filme: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteMovie(dynamic id) async {
    setState(() => _isLoading = true);
    try {
      final response = await _client.delete(Uri.parse('$_apiUrl/$id'));
      if (response.statusCode == 200) {
        _fetchMovies();
        _showSuccess("Filme removido com sucesso!");
      } else {
        _showError("Erro ao remover filme: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Erro ao remover filme: ${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _titleController.clear();
    _posterUrlController.clear();
    _ratingController.clear();
    _durationController.clear();
    _overviewController.clear();
    _trailerUrlController.clear();
    _isNowPlaying = false;
    _isPopular = false;
    _editingMovieId = null;
    for (var controller in _genreControllers) {
      controller.clear();
    }
    if (_genreControllers.length > 1) {
      _genreControllers.removeRange(1, _genreControllers.length);
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red[800],
        ),
      );
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green[800],
        ),
      );
    }
  }

  void _editMovie(Map<String, dynamic> movie) {
    _editingMovieId = movie['id'];
    _titleController.text = movie['title'] ?? '';
    _posterUrlController.text = movie['posterUrl'] ?? '';
    _ratingController.text = movie['rating']?.toString() ?? '0';
    _durationController.text = movie['duration'] ?? '';
    _overviewController.text = movie['overview'] ?? '';
    _trailerUrlController.text = movie['trailerUrl'] ?? '';
    _isNowPlaying = movie['isNowPlaying'] ?? false;
    _isPopular = movie['isPopular'] ?? false;

    List<dynamic> movieGenres = movie['genres'] ?? [];
    _genreControllers.clear();
    if (movieGenres.isNotEmpty) {
      for (var genre in movieGenres) {
        _genreControllers.add(TextEditingController(text: genre.toString()));
      }
    } else {
      _genreControllers.add(TextEditingController());
    }

    _showMovieFormDialog(isEditing: true);
  }

  void _showMovieFormDialog({bool isEditing = false}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEditing ? 'Editar Filme' : 'Adicionar Filme',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildMovieForm(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_editingMovieId != null) {
                          _updateMovie(_editingMovieId);
                        } else {
                          _addMovie();
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isEditing ? 'Salvar' : 'Adicionar',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieForm() {
    return Column(
      children: [
        _buildFormField(
          controller: _titleController,
          label: 'Título*',
        ),
        const SizedBox(height: 15),
        _buildFormField(
          controller: _posterUrlController,
          label: 'Poster URL',
        ),
        const SizedBox(height: 15),
        _buildFormField(
          controller: _ratingController,
          label: 'Avaliação (0-10)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        _buildFormField(
          controller: _durationController,
          label: 'Duração',
          hint: 'Ex: 2h 30min',
        ),
        const SizedBox(height: 15),
        _buildGenreFields(),
        const SizedBox(height: 15),
        _buildFormField(
          controller: _overviewController,
          label: 'Sinopse',
          maxLines: 3,
        ),
        const SizedBox(height: 15),
        _buildFormField(
          controller: _trailerUrlController,
          label: 'Trailer URL',
        ),
        const SizedBox(height: 15),
        _buildCheckbox(
          value: _isNowPlaying,
          onChanged: (value) {
            setState(() {
              _isNowPlaying = value ?? false;
            });
          },
          label: 'Em Cartaz',
        ),
        const SizedBox(height: 10),
        _buildCheckbox(
          value: _isPopular,
          onChanged: (value) {
            setState(() {
              _isPopular = value ?? false;
            });
          },
          label: 'Popular',
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
    );
  }

  Widget _buildGenreFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gêneros:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ..._genreControllers.map((controller) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    controller: controller,
                    label: 'Gênero ${_genreControllers.indexOf(controller) + 1}',
                  ),
                ),
                if (_genreControllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _genreControllers.remove(controller);
                      });
                    },
                  ),
              ],
            ),
          );
        }).toList(),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _genreControllers.add(TextEditingController());
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Adicionar Gênero',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String label,
  }) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white),
            ),
            child: value
                ? const Icon(Icons.check, size: 18, color: Colors.black)
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Gerenciamento de Filmes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
                    : movies.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.movie_creation,
                        color: Colors.white54,
                        size: 50,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Nenhum filme cadastrado',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _showMovieFormDialog(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Adicionar Primeiro Filme',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Card(
                      color: Colors.white.withOpacity(0.15),
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title'] ?? 'Sem título',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (movie['posterUrl'] != null &&
                                movie['posterUrl'].isNotEmpty)
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    movie['posterUrl'],
                                    height: 180,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                    const Icon(
                                      Icons.broken_image,
                                      color: Colors.white54,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 15),
                            if (movie['rating'] != null)
                              _buildMovieInfo('Avaliação',
                                  '${movie['rating']?.toStringAsFixed(1)}/10'),
                            if (movie['duration'] != null)
                              _buildMovieInfo('Duração', movie['duration']),
                            if (movie['genres'] != null &&
                                movie['genres'].isNotEmpty)
                              _buildMovieInfo('Gêneros',
                                  (movie['genres'] as List).join(', ')),
                            if (movie['overview'] != null &&
                                movie['overview'].isNotEmpty)
                              _buildMovieInfo(
                                  'Sinopse', movie['overview']),
                            if (movie['trailerUrl'] != null &&
                                movie['trailerUrl'].isNotEmpty)
                              _buildMovieInfo(
                                  'Trailer', movie['trailerUrl']),
                            _buildMovieInfo(
                              'Status',
                              '${movie['isNowPlaying'] == true ? 'Em cartaz' : 'Não em cartaz'} • '
                                  '${movie['isPopular'] == true ? 'Popular' : 'Não popular'}',
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _editMovie(movie),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.white.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Editar',
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () =>
                                      _confirmDelete(movie['id']),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.red.withOpacity(0.3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Excluir',
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => _showMovieFormDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Adicionar Novo Filme',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 15),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(dynamic id) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Confirmar Exclusão',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tem certeza que deseja excluir este filme?',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      _deleteMovie(id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Excluir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _posterUrlController.dispose();
    _ratingController.dispose();
    _durationController.dispose();
    _overviewController.dispose();
    _trailerUrlController.dispose();
    for (var controller in _genreControllers) {
      controller.dispose();
    }
    _client.close();
    super.dispose();
  }
}

