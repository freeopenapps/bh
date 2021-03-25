//
// ========= VIEWS
//
class EntryViewStrings {
  static const newEntryBtn = '+ New Entry';
  static const backupBtn = 'Backup / Restore';
}

//
// ========= WIDGETS
//
class EntryRowsStrings {
  static const ketonesTitle = 'Ketones';
  static const ketonesUnits = 'mmol/L';
  static const glucoseTitle = 'Glucose';
  static const glucoseUnits = 'mg/dL';
  static const weightTitle = 'Weight';
  static const weightUnits = 'lb';
  static const pressureTitle = 'Pressure';
  static const pressureUnits = 'dia/sys/bpm';
}

class EntryRowItemStrings {
  static const name = '';
}

class EditEntryStrings {
  static const deleteDialogTitle = 'Delete Entry';
  static const deleteDialogCancelBtn = 'Cancel';
  static const deleteDialogDeleteBtn = 'Delete';

  static const entryTitle = 'Update Entry';
  static const entryKetonesFld = 'Ketones';
  static const entryGlucoseFld = 'Glucose';
  static const entryWeightFld = 'Weight';
  static const entryPressureFld = 'Pressure';
  static const entryNoteFld = 'Note';

  static const saveBtn = 'Save Changes';
  static const deleteBtn = 'Delete';
}

class AppBarTitleStrings {
  static const name = '';
}

class AddEntryStrings {
  static const name = '';
}

class BackupModalStrings {
  // Selective Backup
  static const selBackupTitle = 'Selective Backup';
  static const selBackupRange = 'Select date range';
  static const selBackupMsg = 'Write data from given range to files on device';
  static const selBackupBtn = 'Create Backup';
  static const selBackupDialogTitle = 'Backup Created';
  static const selBackupDialogMsg = 'Backup Created!';

  // Full Backup
  static const fullBackupTitle = 'Backup';
  static const fullBackupMsg = 'Backup all data to files on device';
  static const fullBackupBtn = 'Backup All Data';
  static const fullBackupDialogTitle = 'Full Backup Created';
  static const fullBackupDialogMsg = 'Full Backup Created!';

  // Restore from files
  static const restoreTitle = 'Restore';
  static const restoreMsg = 'Load data from files on device';
  static const restoreBtn = 'Restore from files';
  static const restoreDialogTitle = 'Backup Loaded';
  static const restoreDialogMsg = 'Backup data loaded into app!';

  // Clear App DB
  static const clearDataTitle = 'Reset App';
  static const clearDataMsg = 'Clear the application database';
  static const clearDataBtn = 'Reset App';
  static const clearDataDialogTitle = 'Reset Application';
  static const clearDataDialogMsg = 'All data cleared from app database!';

  // Delete Backup files
  static const delFilesTitle = 'Remove Backup Files';
  static const delFilesMsg = 'Remove backup files from this device';
  static const delFilesBtn = 'Remove Files';
  static const delFilesDialogTitle = 'Remove Backup Files';
  static const delFilesDialogMsg = 'Backup files deleted from this device!';
}
