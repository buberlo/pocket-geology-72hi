import Foundation

extension Date {
    // MARK: - Formatters

    private static let layerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()

    private static let shortLayerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    private static let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()

    private static let reportDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()

    private static let relativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()

    // MARK: - Sediment Layer Labels

    var sedimentLayerLabel: String {
        Self.layerFormatter.string(from: self)
    }

    var sedimentLayerShortLabel: String {
        Self.shortLayerFormatter.string(from: self)
    }

    var sedimentLayerSublabel: String {
        "\(Self.weekdayFormatter.string(from: self)), \(Self.timeFormatter.string(from: self))"
    }

    var sedimentDepthLabel: String {
        let days = max(0, Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0)
        switch days {
        case 0...7:
            return "Shallow"
        case 8...30:
            return "Buried"
        case 31...180:
            return "Deep"
        default:
            return "Fossilized"
        }
    }

    // MARK: - Age and Forgotten-Moment Labels

    var relativeAgeLabel: String {
        Self.relativeFormatter.localizedString(for: self, relativeTo: Date())
    }

    var forgottenMomentLabel: String {
        let days = max(0, Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0)
        switch days {
        case 0:
            return "Today"
        case 1:
            return "Yesterday"
        case 2...7:
            return "\(days) days ago"
        case 8...30:
            return "\(days / 7) weeks ago"
        case 31...180:
            return "\(days / 30) months ago"
        default:
            return "\(days / 365) years ago"
        }
    }

    // MARK: - Weekly Report Formatting

    var weeklyReportTitle: String {
        "Landslide Report · \(Self.reportDayFormatter.string(from: self))"
    }

    var weeklyReportSubtitle: String {
        "Forgotten moments from \(sedimentLayerShortLabel)"
    }

    var reportPeriodLabel: String {
        let calendar = Calendar.current
        guard
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)),
            let endOfWeek = calendar.date(byAdding: DateComponents(day: 7, second: -1), to: startOfWeek)