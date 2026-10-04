---
name: generate-schema
description: Generates a commands.json JSON Schema entry for a given bash script in the cmd/ directory.
---

# Generate Command Schema

When the user asks you to add a new command or generate a schema for an existing bash script in `rapidctl-container`, follow these instructions to update `commands.json`.

## Instructions

1. **Read the Bash Script**: Read the specified bash script in the `cmd/` directory to understand its purpose and the arguments it accepts. Pay attention to whether it takes positional arguments (e.g. `$1`, `$2`, `$@`) or flags (e.g. `--input`, `--name`).
2. **Determine the Schema**: Create a JSON schema that describes the parameters. 
   - Use standard JSON schema types (`string`, `integer`, `boolean`, etc.).
   - Include a `description` for each property to provide context to the LLM agent.
   - Define which properties are `required`.
3. **Determine the Argument Mapping**: Determine how the properties map to CLI arguments.
   - `positional`: An array of property names that map to positional arguments in order.
   - `flags`: A mapping of property names to their corresponding CLI flags (e.g., `"name": "--name"`).
4. **Update commands.json**: Update the `commands.json` file in the root of the repository with the new command entry. 

## Example `commands.json` Entry

```json
{
  "my-command": {
    "summary": "This is a summary of what the command does.",
    "parameters": {
      "type": "object",
      "properties": {
        "input_string": {
          "type": "string",
          "description": "The string to process."
        },
        "verbose": {
          "type": "boolean",
          "description": "Enable verbose output."
        }
      },
      "required": ["input_string"]
    },
    "argument_mapping": {
      "positional": ["input_string"],
      "flags": {
        "verbose": "--verbose"
      }
    }
  }
}
```
