# Architecture

```mermaid
graph LR
    FrontEnd["Front-end"] -->|Sends advance request| EVMChain["EVM Chain"]
    EVMChain -->|Processes input| CartesiMachine["Cartesi Machine"]
    FrontEnd -->|Sends inspect request| CartesiMachine
    CartesiMachine -->|Handles rollup requests| HTTPServer["HTTP Rollups Server"]
    CartesiMachine -->|Processes business logic| Backend["Back-end"]

    subgraph CartesiRollupsFramework["Cartesi Rollups Framework"]
        subgraph CartesiMachine["Cartesi Machine"]
            HTTPServer["HTTP Rollups ZOGGERS"]
            Backend["Back-end"]
        end
    end
