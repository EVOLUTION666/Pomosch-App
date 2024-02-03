// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardsQuery: GraphQLQuery {
  public static let operationName: String = "WardsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query WardsQuery { wards { __typename nodes { __typename id publicInformation { __typename city dateOfBirth name { __typename fullName firstName middleName } photo { __typename id url(asAttachment: false) } story } } } }"#
    ))

  public init() {}

  public struct Data: PomoschAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wards", Wards?.self),
    ] }

    /// Подопечные
    public var wards: Wards? { __data["wards"] }

    /// Wards
    ///
    /// Parent Type: `WardsConnection`
    public struct Wards: PomoschAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.WardsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node]?.self),
      ] }

      /// A flattened list of the nodes.
      public var nodes: [Node]? { __data["nodes"] }

      /// Wards.Node
      ///
      /// Parent Type: `Ward`
      public struct Node: PomoschAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.Ward }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", PomoschAPI.ID.self),
          .field("publicInformation", PublicInformation.self),
        ] }

        /// Уникальный идентификатор
        public var id: PomoschAPI.ID { __data["id"] }
        /// Общедоступная информация о подопечном
        public var publicInformation: PublicInformation { __data["publicInformation"] }

        /// Wards.Node.PublicInformation
        ///
        /// Parent Type: `WardPublicInformation`
        public struct PublicInformation: PomoschAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.WardPublicInformation }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("city", String.self),
            .field("dateOfBirth", PomoschAPI.Date.self),
            .field("name", Name.self),
            .field("photo", Photo.self),
            .field("story", String.self),
          ] }

          /// Населённый пункт проживания
          public var city: String { __data["city"] }
          /// Дата рождения
          public var dateOfBirth: PomoschAPI.Date { __data["dateOfBirth"] }
          /// Имя
          public var name: Name { __data["name"] }
          /// Фотография подопечного
          public var photo: Photo { __data["photo"] }
          /// История подопечного
          public var story: String { __data["story"] }

          /// Wards.Node.PublicInformation.Name
          ///
          /// Parent Type: `Nomen`
          public struct Name: PomoschAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.Nomen }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("fullName", String.self),
              .field("firstName", String.self),
              .field("middleName", String?.self),
            ] }

            /// Полное имя (Имя Отчество Фамилия)
            public var fullName: String { __data["fullName"] }
            /// Имя
            public var firstName: String { __data["firstName"] }
            /// Отчество
            public var middleName: String? { __data["middleName"] }
          }

          /// Wards.Node.PublicInformation.Photo
          ///
          /// Parent Type: `FileInformation`
          public struct Photo: PomoschAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PomoschAPI.Objects.FileInformation }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", String.self),
              .field("url", String.self, arguments: ["asAttachment": false]),
            ] }

            /// Идентификатор файла
            public var id: String { __data["id"] }
            /// Ссылка для отображения или скачивания файла
            public var url: String { __data["url"] }
          }
        }
      }
    }
  }
}
