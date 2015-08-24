import UIKit

class TimePickerTextField: UITextField, UIPickerViewDelegate, UITextFieldDelegate {

    private var picker = UIDatePicker()
    private var toolBar = UIToolbar()
    var time: String? {
        didSet {
            text = time
            let formatter = NSDateFormatter()
            formatter.dateFormat = kDateFormat
            if let time = time {
                if let date = formatter.dateFromString(time) {
                    picker.date = date
                }
            }
        }
    }
    var doneText: String = "OK" {
        didSet {
            doneButton.title = doneText
        }
    }
    var completion:(()->Void)?
    private let kDateFormat = "HH:mm"
    private var doneButton: UIBarButtonItem!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPickerView()
        tintColor = UIColor.clearColor()
    }
    
    private func setupPickerView() {
        doneButton = UIBarButtonItem(title: doneText, style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonDidPush:")
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.sizeToFit()
        toolBar.setItems([spacer, doneButton], animated:false)
        
        picker.datePickerMode = UIDatePickerMode.Time
        inputView = picker
        inputAccessoryView = toolBar
    }
    
    func doneButtonDidPush(sender: AnyObject) {
        resignFirstResponder()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = kDateFormat
        time = dateFormatter.stringFromDate(picker.date)
        
        completion?()
    }
}
