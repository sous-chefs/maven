# maven_settings

Resource provider for modifying the maven settings.

## Actions

Action | Description                                    | Default
------ | ---------------------------------------------- | -------
update | Updates a global maven setting to a new value. | Yes

## Attributes

Attribute | Description                                                                       | Type                                | Default
--------- | --------------------------------------------------------------------------------- | ----------------------------------- | -------
path      | Period '.' delimited path to element of the settings that is going to be changed. | String                              | name
value     | The new value to update the path to.                                              | String, TrueClass, FalseClass, Hash |

In order to use this resource you first need to run `settings` recipe which will installed required bury gems for you. Find below exampl on how to update proxy in settings.xml

```ruby
maven_settings "settings.proxies" do
  value "proxy" => {
    "active" => true,
    "protocaol" => "http",
    "host" => "proxy.myorg.com",
    "port" => 80,
    "nonProxyHosts" => ".myorg.com"
  }
end
```
