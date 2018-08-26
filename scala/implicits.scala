import play.api.libs.json.{Json, OWrites}

import scala.util.Try

// Generic Model
trait GenericModel {
  val id: String
}

object GenericModel {

  // Place the implicit here in the OBJECT not in the trait
  implicit val jsWriter = OWrites[ConcreteModel] { m =>
    Json.obj(
      "id" -> m.id
    )
  }
}


case class ConcreteModel(description: String) extends GenericModel {
  val id: String = hashCode().toString
  val name: String = getClass.getSimpleName
}


object ConcreteModel {
  // implicitly convert a "model" to json
  implicit val jsWriter = OWrites[ConcreteModel] { m =>
    Json.obj(
      "id" -> m.id,
      "name" -> m.name,
      "description" -> m.description
    )
  }
}




trait DAO[M <: GenericModel] {
  def create(m: M)(implicit w: OWrites[M]): Boolean = {
    val js = Json.toJson(m)

    println(Json.prettyPrint(js))
    
    // Validate is json
    Try(js).isSuccess
  }
}


case object Repo extends DAO[ConcreteModel]


object CustomJson {
  implicit val jsWriterOmitName = OWrites[ConcreteModel] { m =>
    Json.obj(
      "id" -> m.id,
      "description" -> m.name
    )
  }
}



val model = ConcreteModel("mock object")


Repo.create(model)  // returns true AND allows json writer to be omitted


val omitNameJson = CustomJson.jsWriterOmitName

Repo.create(model)(omitNameJson)  // returns true; omits the "name" field
