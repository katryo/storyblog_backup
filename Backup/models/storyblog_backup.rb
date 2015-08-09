# encoding: utf-8

##
# Backup Generated: backup_config
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup_config [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:storyblog_backup, 'Backup storyblog data to S3') do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = 'storyblog_production'
    db.username           = ENV['POSTGRESQL_USERNAME']
    db.password           = ENV['POSTGRESQL_PASSWORD']
    db.host               = "localhost"
    db.port               = 5432
    # db.socket             = "/tmp/pg.sock"
    # When dumping all databases, `skip_tables` and `only_tables` are ignored.
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these", "tables"]
    # db.additional_options = ["-xc", "-E=utf8"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = ENV['S3_ACCESS_KEY']
    s3.secret_access_key = ENV['S3_SECRET']
    # Or, to use a IAM Profile:
    # s3.use_iam_profile = true

    s3.region            = 'ap-northeast-1'
    s3.bucket            = 'storyblog-backup'
    s3.path              = '/backups'
  end

  ##
  # Amazon S3 [Syncer]
  #
  # sync_with Cloud::S3 do |s3|
  #   # AWS Credentials
  #   s3.access_key_id     = ENV['S3_ACCESS_KEY']
  #   s3.secret_access_key = ENV['S3_SECRET']
  #   # Or, to use a IAM Profile:
  #   # s3.use_iam_profile = true
  #
  #   s3.region            = 'ap-northeast-1'
  #   s3.bucket            = 'storyblog-backup'
  #   s3.path              = '/backups'
  #   s3.mirror            = true
  #   s3.thread_count      = 10
  #
  #   s3.directories do |directory|
  #     directory.add "/path/to/directory/to/sync"
  #     directory.add "/path/to/other/directory/to/sync"
  #
  #     # Exclude files/folders from the sync.
  #     # The pattern may be a shell glob pattern (see `File.fnmatch`) or a Regexp.
  #     # All patterns will be applied when traversing each added directory.
  #     directory.exclude '**/*~'
  #     directory.exclude /\/tmp$/
  #   end
  # end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = ENV['GMAIL_USERNAME_DENKINOVEL']
    mail.to                   = ENV['EMAIL_KATRYO']
    mail.address              = "smtp.gmail.com"
    mail.port                 = 587
    mail.domain               = "gmail.com"
    mail.user_name            = ENV['GMAIL_USERNAME_DENKINOVEL']
    mail.password             = ENV['GMAIL_APPLICATION_SPECIFIC_PASSWORD_DENKINOVEL']
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

end
