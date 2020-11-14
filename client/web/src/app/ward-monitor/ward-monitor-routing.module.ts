import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WardMonitorDashboardComponent } from './ward-monitor-dashboard/ward-monitor-dashboard.component';
import { WardMonitorComponent } from './ward-monitor.component';
import {DataVisualizationComponent} from './../ward-monitor/data-visualization/data-visualization.component';
import { PatientProfileComponent } from './patient-profile/patient-profile.component';
import { PatientLoadResolverService } from './patient-load-resolver.service';

const routes: Routes = [
  {
    path: '',
    component: WardMonitorComponent,
    children: [
      {
        path: '',
        pathMatch: 'full',
        component: WardMonitorDashboardComponent
      },
      {
        path: 'live-monitoring',
        component: DataVisualizationComponent
      },
      {
        path: 'patient/:id',
        resolve: {
          patient: PatientLoadResolverService
        },
        component: PatientProfileComponent
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WardMonitorRoutingModule { }
