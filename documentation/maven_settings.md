# maven_settings

Update a value in an existing Maven `settings.xml` file by dotted path.

## Actions

| Action    | Description                                                                  |
|-----------|------------------------------------------------------------------------------|
| `:update` | Update the value at the given dotted path in `settings.xml`. Default action. |

## Properties

| Property        | Type                                | Default                                | Description                                                |
|-----------------|-------------------------------------|----------------------------------------|------------------------------------------------------------|
| `path`          | String                              | name property                          | Dotted path to update, such as `settings.localRepository`. |
| `value`         | String, TrueClass, FalseClass, Hash | none                                   | Value to set at the target path.                           |
| `settings_file` | String                              | `'/usr/local/maven/conf/settings.xml'` | Absolute path to the `settings.xml` file to edit.          |

## Examples

### Change the local repository location

```ruby
maven_settings 'settings.localRepository' do
  value '/srv/maven-repository'
end
```

### Configure proxies in settings.xml

```ruby
maven_settings 'settings.proxies' do
  value(
    'proxy' => {
      'active' => true,
      'protocol' => 'http',
      'host' => 'proxy.example.com',
      'port' => '8080',
      'nonProxyHosts' => '*.example.com|localhost'
    }
  )
end
```

### Update a non-default settings.xml file

```ruby
maven_settings 'settings.localRepository' do
  settings_file '/home/deploy/.m2/settings.xml'
  value '/srv/shared/m2'
end
```

## Notes

- The resource installs the `nori` and `gyoku` gems at compile time.
- `settings_file` must already exist.
- The dotted path must already exist in the XML structure; this resource updates
  values in place and does not create missing parent elements.
