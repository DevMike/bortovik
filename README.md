# Bortovik

# General Coding Recomendations

## Database

 + All migrations should be revertable and tested that down method works
   properly before push to the repository
 + Inrevertable migrations should give warnings but do not stop
   migration process
 + *Any changes to the migration files can be done only before push to
   the origin.* After each push CI starts new build. All changes which
   were made after push to origin wont have any affect on staging/CI
   servers
 + Any data operations in migrations MUST use *unscoped* queries or raw
   SQL to prevent any DB version incompatibility

### ActiveRecord consistency
  1. Model inclusions
  2. Attribute protection: attr_accessible
  3. Associations
  4. Class-Level Method Invocations (acts_as_list, etc.)
  5. Scopes (default_scope, then named scopes)
  6. Callbacks in invocation order
  7. Any attr_accessor declarations
  8. Validations
  9. Class methods
  10. Instance methods (starting with to_s, to_param)

### Mailers
  1. Use DJ to send emails in the background

## Internationalization
 + All texts, links, notes and emails should be implemented using Rails
   i18n built in capabilities
 + All models mush have translated name under
   activerecord.models.<model_name> section
 + All human readable attributes for any model must be defined under
   activerecord.attributes.<model_name> section
 + I18n translation keys should be in symbols

## Gems
  + Any of the gems, which are planned to be added to the Gemfile should
    be aggreed with tech lead before
  + All gems provided in Gemfile should have version requirement. For
    most cases this shoudl be major version requirement: for instance
    ~>3.0. In outstanding cases one should use exact version: for
    instance =3.0

## Tests
  + Each implemented story should have acceptance test covering all
    accepptance criterias provided in spec
  + Use FactoryGirl.build(:company) instead of Company.new(FactoryGirl.attributes_for(:company))
    since some factories might have after_build callback

### Autotests
  + Run `spork` to run preloaded rails env and speed rspec run. Note
    that the `rake` command per se loads the whole rails env, so to run
    tests using spork preloaded rails env use `rspec spec` command
  + Run `autotest` to run test instantly, triggered by project changes

    **WARNING:** Autotest does not replace whole test suite run after
    pull/push to origin flow

## Security
  + Mass-assignment is disabled by default. All public fields accessible by user should be listed in attr_accessible class method of model

## GIT
+ [Rebase][1] is prefered over merge. There should not be any merge commits in the
  master branch.
  [1]: http://www.randyfay.com/node/91

# Definition of Done

  These criteria need to be fulfilled for the story to be marked as "completed" in Pivotal.

  + The story is implemented and tests are created
  + The story passes the acceptance tests
  + The story does not increase the "technical debt"
  + The story was integrated into the overall system
  + The story was successfully deployed to the staging environment
  + The story was accepted by the product owner
