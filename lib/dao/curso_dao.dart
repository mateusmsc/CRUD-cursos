import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_curso_firebase/model/curso.dart';

class CursoDao {
  final databaseReference = FirebaseFirestore.instance;
  final String COLECAO = "curso";
  Future<String> inserir(Curso curso) async {
    try {
      DocumentReference ref =
          await databaseReference.collection(COLECAO).add(curso.toMap());
      return ref.id;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> alterar(Curso curso) async {
    try {
      await databaseReference
          .collection(COLECAO)
          .doc(curso.id)
          .update(curso.toMap());
      return "Registro atualizado";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Curso>> findAll() async {
    QuerySnapshot cursos = await databaseReference.collection(COLECAO).get();
    List<Curso> listaCursos = List();
    cursos.docs.forEach((elemento) {
      listaCursos.add(Curso.fromJson(elemento.data(), elemento.id));
    });
    return listaCursos;
  }

  Future<String> excluir(String id) async {
    try {
      await databaseReference.collection(COLECAO).doc(id).delete();
      return "Registro excluído com projeto";
    } catch (e) {
      return e.toString();
    }
  }
}
