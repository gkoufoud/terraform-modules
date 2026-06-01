#!/bin/bash

json_file=${1:-"api_versions.json"}

echo "Generating JSON of Azure Resource Providers and latest stable API versions..."

az provider list --output json | jq '
  map(
    # Store the lowercase namespace (e.g., microsoft.datafactory)
    (.namespace | ascii_downcase) as $ns |
    
    # Process the resource types for this namespace
    (
      .resourceTypes | map(
        # Store the lowercase resource type (e.g., factories)
        (.resourceType | ascii_downcase) as $rt |
        
        # Calculate the latest stable version
        (
          [ .apiVersions[] | select(test("preview|alpha|beta|rc"; "i") | not) ] | sort | last
        ) as $latest_stable |
        
        # Only keep it if a stable version exists
        select($latest_stable != null) |
        
        # Format as key-value pair for from_entries
        {key: $rt, value: $latest_stable}
      ) | from_entries
    ) as $resources |
    
    # Ignore namespaces that end up completely empty (no stable resources)
    select($resources != {}) |
    
    # Format the top level as key-value pair for the final from_entries
    {key: $ns, value: $resources}
    
  ) | from_entries
' > $json_file

echo "Done! Output saved to $json_file"