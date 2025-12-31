---
name: Monitoring Issue
about: Report issues with monitoring, metrics, or dashboards
title: '[MONITORING] '
labels: monitoring
assignees: ''
---

## Monitoring Issue Description
A clear description of the monitoring/metrics issue you're experiencing.

## Affected Component
- [ ] Prometheus (metrics collection)
- [ ] Grafana (dashboards/visualization)
- [ ] Node Exporter (server metrics)
- [ ] cAdvisor (container metrics)
- [ ] Custom metrics/alerts

## Issue Type
- [ ] Metrics not being collected
- [ ] Dashboard not displaying data
- [ ] Alert not triggering
- [ ] Performance issue
- [ ] Configuration problem
- [ ] Data retention issue

## Expected Behavior
What should the monitoring system be doing?

## Actual Behavior
What is actually happening?

## Environment
- OS: [e.g., Ubuntu 22.04]
- Docker Version: [e.g., 24.0.0]
- Services affected: [e.g., prometheus, grafana]

## Metrics/Dashboard Details
If related to specific metrics or dashboard:
- Metric name: 
- Dashboard name/ID: 
- Time range: 
- Query used: 

## Configuration
Please share relevant configuration:

```yaml
# Paste relevant config here (prometheus.yml, dashboard JSON, etc.)
```

## Screenshots
If applicable, add screenshots of:
- Grafana dashboard
- Prometheus targets page
- Error messages

## Logs
```bash
# Prometheus logs
./manage.sh logs prometheus

# Grafana logs  
./manage.sh logs grafana
```

```
[Paste relevant logs here]
```

## Additional Context
Any other context about the monitoring issue.