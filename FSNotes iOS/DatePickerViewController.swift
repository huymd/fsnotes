//
//  DatePickerViewController.swift
//  FSNotes iOS
//
//  Created by Александр on 01.02.2022.
//  Copyright © 2022 Oleksandr Glushchenko. All rights reserved.
//

import Foundation
import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!

    public var notes: [Note]?

    override func viewDidLoad() {
        super.viewDidLoad()

        saveBarButton.action = #selector(saveDate)
        cancelBarButton.action = #selector(cancel)

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }

        if let date = notes?.first?.creationDate {
            datePicker.date = date
        }
    }

    @IBAction func saveDate(_ sender: Any) {
        guard let notes = self.notes else { return }

        for note in notes {
            _ = note.setCreationDate(date: datePicker.date)
        }

        DispatchQueue.main.async {
            UIApplication.getVC().notesTable.reloadRows(notes: notes)
        }

        self.notes = nil
        dismiss(animated: true)
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
