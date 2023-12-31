import Foundation

struct Formatter {
    static func toShortDate(_ dateString: String) -> String {
        let dateFormatterApi = DateFormatter()
        let dateFormatterReleased = DateFormatter()
        
        dateFormatterApi.dateFormat = "yyyy-MM-dd"
        dateFormatterReleased.dateFormat = "MMM dd, yyyy"
        
        guard let date = dateFormatterApi.date(from: dateString) else {
            return dateString
        }
        
        let released = dateFormatterReleased.string(from: date)
        
        return released
    }
    
    static func formatNumber(_ number: Int) -> String {
        let num = abs(Double(number))
        let sign = (number < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(number)"

        default:
            return "\(sign)\(number)"
        }
    }
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / multiplier
        return originalDecimal
    }
}
