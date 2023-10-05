package com.example.teste_plugin

import android.content.Context
import android.util.Log
import androidx.health.services.client.HealthServices
import androidx.health.services.client.MeasureCallback
import androidx.health.services.client.data.Availability
import androidx.health.services.client.data.DataPointContainer
import androidx.health.services.client.data.DataType
import androidx.health.services.client.data.DataTypeAvailability
import androidx.health.services.client.data.DeltaDataType
import androidx.health.services.client.data.LocationData
import androidx.health.services.client.unregisterMeasureCallback
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.launch

class HealthServiceManager(private val context: Context) {
    private val healthClient = HealthServices.getClient(context)
    private val measureClient = healthClient.measureClient
    private val coroutineScope = CoroutineScope(SupervisorJob())

    private var currentHealth = 0.0
    private var _lastMap: Map<String, Any?>? = null

    val locationData = MutableSharedFlow<LocationData>()
    val heartRateData = MutableSharedFlow<Double>()

    // health rate
    private val heartRateCallback = object : MeasureCallback {
        override fun onAvailabilityChanged(
            dataType: DeltaDataType<*, *>,
            availability: Availability
        ) {

            if (availability is DataTypeAvailability) {
                Log.d("HSV", "Disponibilidade dos dados mudou ${availability.id}")
            }
        }

        override fun onDataReceived(data: DataPointContainer) {
            val heartRateBpm = data.getData(DataType.HEART_RATE_BPM)
            Log.d("HSV", heartRateBpm.last().value.toString())

            currentHealth = heartRateBpm.last().value
        }
    }

    // location
    private val locationCallback = object : MeasureCallback {
        override fun onAvailabilityChanged(
            dataType: DeltaDataType<*, *>,
            availability: Availability
        ) {

            if (availability is DataTypeAvailability) {
                Log.d("HSV", "Disponibilidade dos dados mudou ${availability.id}")
            }
        }

        override fun onDataReceived(data: DataPointContainer) {
            val location = data.getData(DataType.LOCATION)
            Log.d("HSV", location.last().value.toString())

            _lastMap = mapOf(
                Pair("latitude", location.last().value.latitude),
                Pair("longitude", location.last().value.longitude),
                Pair("altitude", location.last().value.altitude),
                Pair("bearing", location.last().value.bearing)
            )


        }
    }

    // metodos

    fun getLocationDataMap () = _lastMap
    fun getHeatRateData () = currentHealth

    // Registra o callback de frequência cardíaca
    fun registerCallbacks() {
        measureClient.registerMeasureCallback(DataType.HEART_RATE_BPM, heartRateCallback)
        measureClient.registerMeasureCallback(DataType.LOCATION, locationCallback)

        coroutineScope.launch {
            for (x in 0..100) {
                heartRateData.emit(x.toDouble())
                delay(1000)

            }
        }
    }


    // Cancela o registro do callback de frequência cardíaca
    fun unregisterCallbacks() {
        // Lança uma corrotina para cancelar o registro do callback
        coroutineScope.launch {
            measureClient.unregisterMeasureCallback(DataType.HEART_RATE_BPM, heartRateCallback)
            measureClient.unregisterMeasureCallback(DataType.LOCATION, locationCallback)
        }
    }


}