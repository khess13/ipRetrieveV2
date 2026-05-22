import { LightningElement, api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import logError from '@salesforce/apex/ErrorLoggerCls.logError';

export default class IpAddressRetrieve extends LightningElement {
    @api ipAddr;

    async connectedCallback() {
        try {
            const response = await fetch('/services/apexrest/getClientIp/');
            if (!response.ok) {
                this.logErrorToServer('Network response was not ok: ' + response.statusText);
                return;
            }
            const data = await response.json();
            if (data && data.ip) {
                this.ipAddr = data.ip;
                this.dispatchEvent(new FlowAttributeChangeEvent('ipAddr', this.ipAddr));
            } else {
                this.logErrorToServer('Invalid response data: ' + JSON.stringify(data));
            }
        } catch (error) {
            this.logErrorToServer('connectedCallback error: ' + error.message);
        }
    }

    async logErrorToServer(errorMessage) {
        try {
            await logError({ errorMessage });
        } catch (e) {
            console.error('Error logging to server:', e);
        }
    }
}