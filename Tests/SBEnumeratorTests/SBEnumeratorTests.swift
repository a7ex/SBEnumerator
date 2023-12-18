import XCTest
@testable import SBEnumeratorLib

class SBEnumeratorTests: XCTestCase {
    func testMainStoryboard() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: false) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "Storyboard", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
// All UITableViewCell reuseIdentifiers, which were found in all storyboards
// and xibs at the last time SBEnumerator ran and scanned the IB files
enum TableCell: String {
    case cell_Identifier_with_spaces = "Cell Identifier with spaces"
    case cellIdentifier = "CellIdentifier"
}
"""
        XCTAssertEqual(expected, sut.tvCellIdentifiersEnum(blockIndent: ""))
        let expectedCVCells = """
// All UICollectionViewCell reuseIdentifiers, which were found in all storyboards
// and xibs at the last time SBEnumerator ran and scanned the IB files
enum CollectionCell: String {
    case collectionViewCell = "CollectionViewCell"
}
"""
        XCTAssertEqual(expectedCVCells, sut.cvCellIdentifiersEnum())
        let expectedAccessibility = """
// All Accessibility Identifiers, which were found in all storyboards
// and xibs at the last time SBEnumerator ran and scanned the IB files
enum Accessibility: String {
    case button_with_Special_Char_Äß-2 = "Button with Special Char Äß-2"
}
"""
        XCTAssertEqual(expectedAccessibility, sut.aiCellIdentifiersEnum())

        XCTAssertEqual("Duplicate accessibility identifiers: \"Button with Special Char Äß-2\"!\n", duplicate)
    }

    func testMainStoryboardStaticString() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: true) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "Storyboard", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
xxx// All UITableViewCell reuseIdentifiers, which were found in all storyboards
xxx// and xibs at the last time SBEnumerator ran and scanned the IB files
xxxenum TableCell {
xxx    static let cell_Identifier_with_spaces = "Cell Identifier with spaces"
xxx    static let cellIdentifier = "CellIdentifier"
xxx}
"""
        XCTAssertEqual(expected, sut.tvCellIdentifiersEnum(blockIndent: "xxx"))

        let expectedCVCells = """
xxx// All UICollectionViewCell reuseIdentifiers, which were found in all storyboards
xxx// and xibs at the last time SBEnumerator ran and scanned the IB files
xxxenum CollectionCell {
xxx    static let collectionViewCell = "CollectionViewCell"
xxx}
"""
        XCTAssertEqual(expectedCVCells, sut.cvCellIdentifiersEnum(blockIndent: "xxx"))
        let expectedAccessibility = """
xxx// All Accessibility Identifiers, which were found in all storyboards
xxx// and xibs at the last time SBEnumerator ran and scanned the IB files
xxxenum Accessibility {
xxx    static let button_with_Special_Char_Äß-2 = "Button with Special Char Äß-2"
xxx}
"""
        XCTAssertEqual(expectedAccessibility, sut.aiCellIdentifiersEnum(blockIndent: "xxx"))
        XCTAssertEqual("Duplicate accessibility identifiers: \"Button with Special Char Äß-2\"!\n", duplicate)
    }

    func testLaunchScreen() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: false) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "LaunchScreen", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
// All Accessibility Identifiers, which were found in all storyboards
// and xibs at the last time SBEnumerator ran and scanned the IB files
enum Accessibility: String {
    case label_identifier = "Label identifier"
}
"""
        XCTAssertEqual("", sut.tvCellIdentifiersEnum())
        XCTAssertEqual(expected, sut.aiCellIdentifiersEnum())
        XCTAssertEqual("", duplicate)
    }

    func testLaunchScreenStaticString() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: true) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "LaunchScreen", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
    // All Accessibility Identifiers, which were found in all storyboards
    // and xibs at the last time SBEnumerator ran and scanned the IB files
    enum Accessibility {
        static let label_identifier = "Label identifier"
    }
"""
        XCTAssertEqual("", sut.tvCellIdentifiersEnum())
        XCTAssertEqual(expected, sut.aiCellIdentifiersEnum(blockIndent: "    "))
        XCTAssertEqual("", duplicate)
    }

    func testXib() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: false) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "View", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
// All Accessibility Identifiers, which were found in all storyboards
// and xibs at the last time SBEnumerator ran and scanned the IB files
enum Accessibility: String {
    case aSwitch
}
"""
        XCTAssertEqual("", sut.tvCellIdentifiersEnum())
        XCTAssertEqual(expected, sut.aiCellIdentifiersEnum())
        XCTAssertEqual("", duplicate)
    }

    func testXibStaticString() throws {
        var duplicate = ""
        let sut = InterfaceBuilderParser(createStaticStrings: true) { error in
            duplicate = error
        }
        let url = try XCTUnwrap(Bundle.module.url(forResource: "View", withExtension: "xml"))
        let parser = try XCTUnwrap(XMLParser(contentsOf: url))
        parser.delegate = sut
        parser.parse()
        let expected = """
    // All Accessibility Identifiers, which were found in all storyboards
    // and xibs at the last time SBEnumerator ran and scanned the IB files
    enum Accessibility {
        static let aSwitch = "aSwitch"
    }
"""
        XCTAssertEqual("", sut.tvCellIdentifiersEnum())
        XCTAssertEqual(expected, sut.aiCellIdentifiersEnum(blockIndent: "    "))
        XCTAssertEqual("", duplicate)
    }
}
